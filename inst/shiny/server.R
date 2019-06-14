library(shinyjs)
library(rems2aquachem)

server <- function(input, output) {

  status <- reactiveValues(check_rems_recent = TRUE,
                           check_rems_historic = TRUE)

  # Check status and update EMS data -------------------------------------------

  # Update recent REMS data
  observeEvent(input$update_recent, {
    withProgress(message = "Updating recent EMS data",
                 detail = HTML("This may take several minutes"), {
      withCallingHandlers({
        # Catch errors if curl issues and try again
        t <- try(rems::get_ems_data(force = TRUE, ask = FALSE), silent = TRUE)
        if(any(class(t) == "try-error")) {
          rems::get_ems_data(force = TRUE, ask = FALSE)
        }

        message("Done")
        status$check_rems_recent <- TRUE
        },
        message = function(m) {
          shinyjs::html(id = "messages", html = m$message, add = TRUE)
        }
      )
    })
  })

  # Update historic REMS data
  observeEvent(input$update_historic, {
    withProgress(message = "Updating historic EMS data",
                 detail = HTML("This may take up to an hour"), {
      withCallingHandlers({
        t <- try(rems::download_historic_data(force = TRUE, ask = FALSE), silent = TRUE)
        if(any(class(t) == "try-error")) {
          rems::download_historic_data(force = TRUE, ask = FALSE)
        }
        message("Done")
        status$check_rems_historic <- TRUE
        },
        message = function(m) {
          shinyjs::html(id = "messages", html = m$message, add = TRUE)
        }
      )
    })
  })

  observeEvent(input$check_status, {
    status$check_rems_recent <- TRUE
    status$check_rems_historic <- TRUE
  })

  # Get recent status
  rems_status_recent <- eventReactive(status$check_rems_recent, {
    server_recent <- rems:::get_file_metadata("2yr")$server_date
    cache_recent <- rems:::get_cache_date("2yr")
    status$check_rems_recent <- FALSE
    server_recent == cache_recent
  })

  # Get historic status
  rems_status_historic <- eventReactive(status$check_rems_historic, {
    server_historic <- rems:::get_file_metadata("historic")$server_date
    cache_historic <- rems:::get_cache_date("historic")
    status$check_rems_historic <- FALSE
    server_historic == cache_historic
  })


  # Output recent status
  output$rems_status_recent <- renderValueBox({
    valueBox(value = if(!rems_status_recent()) "Out-of-date" else "Up-to-date",
             subtitle = "Recent EMS Data",
             color = if(!rems_status_recent()) "red" else "green"
    )
  })

  # Output historic status
  output$rems_status_historic <- renderValueBox({
    valueBox(value = if(!rems_status_historic()) "Out-of-date" else "Up-to-date",
             subtitle = "Historic EMS Data",
             color = if(!rems_status_historic()) "red" else "green"
    )
  })


  # Download EMS data ----------------------------------------------------------

  ems_ids <- reactive({
    input$ems_ids %>%
      stringr::str_remove_all(pattern = "\"") %>%
      stringr::str_split(pattern = ",[ ]*", simplify = TRUE) %>%
      as.vector() %>%
      .[. != ""]
  })

  data_ac <- eventReactive(input$get_data, {
    req(ems_ids())
    validate(need({
      len <- nchar(ems_ids()) == 7
      sym <- stringr::str_detect(ems_ids(), "^[a-zA-Z0-9]*$")
      all(len) & all(sym)},
      message = paste0("Invalid EMS ID(s): ",
                       paste0(ems_ids()[!nchar(ems_ids()) == 7 |
                                          !stringr::str_detect(ems_ids(), "^[a-zA-Z0-9]*$")],
                              collapse = ", "), "")))

    validate(need(
      rems_status_recent(),
      message = "Recent REMS data is out of date, please update it"))
    validate(need(
      rems_status_historic(),
      message = "Historical REMS data is out of date, please update it"))

    r <- try(withCallingHandlers(
      rems_to_aquachem(ems_ids = ems_ids(), date_range = input$date_range,
                       save = FALSE),
      error = function(e) {
        shinyjs::html(id = "messages", html = e$message, add = TRUE)
      },
      message = function(m) {
        shinyjs::html(id = "messages", html = m$message, add = TRUE)
      }
    ), silent = TRUE)

    if(any(class(r) == "try-error")) r <- NULL
    r
  })

  output$data <- DT::renderDT({
    validate(need(class(data_ac()) != "try-error",
                  message = data_ac()[1]))

    DT::datatable(data_ac(),
                  options = list(pageLength = 10, scrollX = TRUE),
                  rownames = FALSE)
  })


  # Download formatted data -------------------------------------------------
  observe({
    req(data_ac())
    shinyjs::enable("download_csv_data")
    shinyjs::enable("download_excel_data")
  })

  output$download_csv_data <- downloadHandler(
    filename = function() {
      paste0("aquachem_", Sys.Date(), ".csv")
    },
    content = function(con) {
      req(data_ac())

      # Reset output messages
      shinyjs::html(id = "messages", html = "")

      readr::write_csv(data_ac(), con, na = "N/A")
    }
  )

  output$download_excel_data <- downloadHandler(
    filename = function() {
      paste0("aquachem_", Sys.Date(), ".xlsx")
    },
    content = function(con) {
      req(data_ac())

      # Reset output messages
      shinyjs::html(id = "messages", html = "")

      d <- data_ac() %>%
        dplyr::mutate_all(~replace(., is.na(.), "N/A"))

      c <- d %>%
        dplyr::mutate(n = 1:dplyr::n()) %>%
        dplyr::group_by(StationID) %>%
        dplyr::summarize(start = n[1]+1, end = dplyr::last(n)+1,
                         colour = NA)

      suppressWarnings(c$colour[2:nrow(c)] <- c("#ac8fb4", "#a9b3cc", "#9dcecc", "#b8e7ba",
                                                "#fef391"))

      wb <- openxlsx::createWorkbook()
      openxlsx::addWorksheet(wb, "aquachem")
      openxlsx::writeData(wb, sheet = 1, x = d)

      for(i in 2:nrow(c)) {
        openxlsx::addStyle(wb, sheet = 1,
                           style = openxlsx::createStyle(fgFill = c$colour[i]),
                           cols = 1:ncol(d), rows = (c$start[i]:c$end[i]),
                           gridExpand = TRUE)
      }
      openxlsx::saveWorkbook(wb, file = con)
      #writexl::write_xlsx(list("aquachem" = d), con)

    }
  )

}
