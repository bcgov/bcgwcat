# Copyright 2021 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

library(shinyjs)
library(bcgwcat)
library(rems)

server <- function(input, output, session) {

  status <- reactiveValues(check_rems_recent = TRUE,
                           check_rems_historic = TRUE)

  # Check status and update EMS data -------------------------------------------

  # Update recent REMS data
  observeEvent(input$update_recent, {
    withProgress(message = "Updating recent EMS data",
                 detail = HTML("This may take several minutes"), {
      withCallingHandlers({
        # Catch errors if curl issues and try again
        t <- try(get_ems_data(force = TRUE, ask = FALSE), silent = TRUE)
        if(any(class(t) == "try-error")) {
          get_ems_data(force = TRUE, ask = FALSE)
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
        t <- try(download_historic_data(force = TRUE, ask = FALSE), silent = TRUE)
        if(any(class(t) == "try-error")) {
          download_historic_data(force = FALSE, ask = FALSE)
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
    cache_historic <- get_cache_date("historic")
    status$check_rems_historic <- FALSE
    Sys.Date() == lubridate::as_date(cache_historic)
  })


  # Output recent status
  output$rems_status_recent <- renderValueBox({
    dt <- get_cache_date("2yr")
    if(dt == -Inf) dt <- "never" else dt <- as.character(lubridate::as_date(dt))
    valueBox(value = if(!rems_status_recent()) "Out-of-date" else "Up-to-date",
             subtitle = paste0("Recent EMS Data (last updated: ", dt, ")"),
             color = if(!rems_status_recent()) "orange" else "green"
    )
  })

  # Output historic status
  output$rems_status_historic <- renderValueBox({
    cache <- get_cache_date("historic")
    dt <- trunc(difftime(Sys.Date(), cache, units = "days"))
    if(dt == Inf) dt <- "never" else dt <- paste0(dt, " days ago")
    valueBox(value = if(!rems_status_historic()) "Out-of-date" else "Up-to-date",
             subtitle = paste0("Historic EMS Data (last updated: ", dt, ")"),
             color = if(!rems_status_historic()) "orange" else "green"
    )
  })


  # Linking ---------------------------------
  observe({
    updateTabItems(session, "box", "Details")
  }) |>
    bindEvent(input$link_details1, input$link_details2, input$link_details3,
              input$link_details4,
              ignoreInit = TRUE)

  # Inputs and Values -------------------------------------------------------

  # EMS IDs - General
  ems_ids <- reactive({
    input$ems_ids %>%
      stringr::str_remove_all(pattern = "\"") %>%
      stringr::str_split(pattern = ",[ ]*", simplify = TRUE) %>%
      as.vector() %>%
      .[. != ""]
  })

  # EMS IDs - Plots
  data_ids <- reactive({
    req(data_ac())
    unique(stringr::str_extract(data_ac()$SampleID[-1], "^[0-9A-Z]+"))
  })

  output$data_ids <- renderUI({
    req(data_ids())
    selectInput("ids_to_plot",
                "EMS IDs to plot (click to add or click/DELETE to remove)",
                data_ids(), multiple = TRUE, selected = data_ids())
  })

  # Parameters - Water Quality Summary
  output$data_params <- renderUI({
    req(data_wq())
    d <- data_wq()
    param <- unique(d$param)
    selectInput("params_to_show",
                "Parameters to include (click to add or click/DELETE to remove)",
                param, multiple = TRUE, selected = param)
  })

  # Reset Params
  observeEvent(input$reset_params, {
    req(data_wq())
    if(!is.null(input$params_to_show)) {
     s <- ""
    } else s <- unique(data_wq()$param)
    updateSelectInput(inputId = "params_to_show", selected = s)

  })


  # Data - EMS --------------------------------------------------------------
  data_ac <- eventReactive(input$get_data, {
    req(ems_ids())
    validate(need({
      len <- nchar(ems_ids()) == 7
      sym <- stringr::str_detect(ems_ids(), "^[a-zA-Z0-9]*$")
      all(len) & all(sym)},
      message = paste0("Invalid EMS ID(s): ",
                       paste0(ems_ids()[!nchar(ems_ids()) == 7 |
                                          !stringr::str_detect(
                                            ems_ids(),
                                            "^[a-zA-Z0-9]*$")],
                              collapse = ", "), "")))

    shinyjs::html(id = "messages",
                  html = "Looking for data...\n",
                  add = TRUE)


    r <- try(withCallingHandlers(
      rems_to_aquachem(ems_ids = ems_ids(), date_range = input$date_range,
                       save = FALSE, interactive = FALSE),
      error = function(e) {
        shinyjs::html(id = "messages", html = e$message, add = TRUE)
      },
      message = function(m) {
        shinyjs::html(id = "messages", html = m$message, add = TRUE)
      }
    ), silent = TRUE)

    if(inherits(r, "try-error")) {
      r <- data.frame()
    } else {
      shinyjs::html(id = "messages",
                    html = "EMS data received - Go to the Preview/Export Tab to explore",
                    add = TRUE)
    }

    r
  })


  # Data - Water Quality ----------------------------------------------------
  data_wq <- reactive({
    req(nrow(data_ac()) > 0)

    data_ac() %>%
      water_quality() %>%
      dplyr::left_join(dplyr::select(bcgwcat:::params, rems_name,
                                     aqua_code),
                       by = "aqua_code") %>%
      dplyr::select("StationID", "SampleID", "Sample_Date", "aqua_code",
                    "param" = "rems_name", "value_transformed" = "value2",
                    "limit", "limitnotes", "units", "quality_problem") %>%
      dplyr::arrange(.data$StationID, .data$SampleID, .data$Sample_Date, .data$param)
  })

  # Data Output - Results -----------------------------------------------------
  output$data <- DT::renderDT({
    validate(need(nrow(data_ac()) > 0, "No data to display"))
    req(input$data_show)

    d <- data_ac()
    units <- dplyr::bind_cols(d[1, ])
    d <- d[-1,]

    if(input$data_show == "rel"){
      d <- dplyr::select(d,
                         dplyr::all_of(c("StationID", "SampleID", "Sample_Date",
                                         "Ca", "Mg", "Na", "Cl", "HCO3", "SO4",
                                         "Ca_meq", "Mg_meq", "Na_meq", "Cl_meq",
                                         "HCO3_meq", "SO4_meq",
                                         "cation_sum", "anion_sum",
                                         "charge_balance", "water_type")))

    }
    d <- d %>%
      dplyr::select("StationID", "SampleID", "Sample_Date",
                    "cation_sum", "anion_sum", "charge_balance",
                    dplyr::everything()) %>%
      dplyr::arrange(.data$StationID, .data$SampleID, .data$Sample_Date)

    col_names <- paste(colnames(d), units[colnames(d)], sep = "\n")

    DT::datatable(d, options = list(pageLength = 20, scrollX = TRUE),
                  colnames = col_names,
                  rownames = FALSE) %>%
      DT::formatRound(columns = c("Ca_meq", "Mg_meq", "Na_meq", "Cl_meq",
                                  "SO4_meq", "HCO3_meq", "cation_sum",
                                  "anion_sum", "charge_balance")) %>%
      DT::formatStyle(columns = "charge_balance",
                      backgroundColor = DT::styleInterval(
                        cuts = c(-10.0001, 10),
                        values = c("#f8d7da", "#d4edda", "#f8d7da")))
  })


  # Data Output - Water Quality -------------------------------------------------
  output$data_wq <- DT::renderDT({
    validate(need(nrow(data_ac()) > 0, "No data to display"))
    req(data_wq(), input$wq_show, input$params_to_show)

    d <- data_wq() %>%
      dplyr::filter(param %in% input$params_to_show)

    if(input$wq_show == "problems") d <- dplyr::filter(d, quality_problem)
    if(input$wq_show == "no_missing") d <- dplyr::filter(d, !is.na(quality_problem))


    q_col <- which(names(d) == "quality_problem")

    d %>%
      dplyr::rename(`AquaChem Code` = aqua_code,
                    Parameter = param,
                    `Value (Transformed)` = value_transformed,
                    `Water Quality Limit (Upper)` = limit,
                    `Limit Notes` = limitnotes) %>%
      dplyr::rename_with(~tools::toTitleCase(
        stringr::str_replace_all(., "_", " "))) %>%
      DT::datatable(options = list(pageLength = 20, scrollX = TRUE,
                                   columnDefs = list(
                                     list(visible = FALSE,
                                          targets = q_col - 1))),
                    rownames = FALSE) %>%
      DT::formatRound(columns = "Value (Transformed)") %>%
      DT::formatStyle(columns = 1:ncol(d), valueColumns = "Quality Problem",
                      backgroundColor = DT::styleEqual(
                        levels = c(TRUE, FALSE, NA),
                        values = c("#f8d7da", "#d4edda", "white")))
  })





# Plots -------------------------------------------------------------
  output$stiff <- renderPlot({
    validate(need(nrow(data_ac()) > 0, "No data to plot"))
    req(data_ac(), input$ids_to_plot, input$ids_to_plot %in% data_ids(),
        input$data_omit)

    params <- data_ac() %>%
      dplyr::filter(!is.na(.data$Ca_meq), !is.na(.data$Mg_meq),
                    !is.na(.data$Na_meq), !is.na(.data$HCO3_meq),
                    !is.na(.data$SO4_meq), !is.na(.data$Cl_meq))

    validate(need(nrow(params) > 1, message = "Missing too many data to plot"))

    p <- stiff_plot(data_ac(), ems_id = input$ids_to_plot,
                    legend = as.logical(input$legend),
                    valid = as.logical(input$data_omit))

    validate(need(!is.null(p), message = "Missing too many data to plot"))

    p
  })

  output$piperplot <- renderPlot({
    validate(need(nrow(data_ac()) > 0, "No data to plot"))
    req(data_ac(), input$ids_to_plot, input$ids_to_plot %in% data_ids(),
        input$data_omit)

    p <- piper_plot(data_ac(), ems_id = input$ids_to_plot,
                    valid = as.logical(input$data_omit),
                    point_size = 0.15, legend = input$legend)

    validate(need(!is.null(p), message = "Missing too many data to plot"))

    p
  }, width = 550, height = 500)



  # Download data -------------------------------------------------
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

      suppressWarnings(c$colour[2:nrow(c)] <- c("#ac8fb4", "#a9b3cc",
                                                "#9dcecc", "#b8e7ba",
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




  # Download plots ----------------------------------------------------------
  output$download_plots <- downloadHandler(
    filename = function() {
      paste0("plots_", Sys.Date(), ".zip")
    },
    content = function(fname) {
      req(input$ids_to_plot, input$data_omit)
      validate(need(nrow(data_ac()) > 1, message = "No plots to download"))
      tempdir <- tempdir()
      d <- data_ac()
      nm <- glue::glue_collapse(input$ids_to_plot, sep = "_")

      ratio <- 2 / length(input$ids_to_plot)

      f <- file.path(tempdir, glue::glue("{nm}_{c('stiff', 'piperplot')}.png"))
      ggplot2::ggsave(f[1],
                      stiff_plot(d, ems_id = input$ids_to_plot,
                                 legend = as.logical(input$legend)),
                      dpi = 300, width = 8, height = 5 * ratio)

      png(f[2], width = 2250, height = 2250, res = 300)
      piper_plot(d, ems_id = input$ids_to_plot,
                 valid = as.logical(input$data_omit),
                 point_size = 0.2, legend = input$legend)
      dev.off()

      zip(zipfile = fname, files = f, flags = "-j")
    }, contentType = "application/zip"
  )


  # Parameter table ----------------------------------------------------------
  output$parameters <- DT::renderDT({

    bcgwcat:::params %>%
      dplyr::select(-"smwr_code", -"type", -"data_type") %>%
      dplyr::rename_with(.fn = ~{
        .x %>%
          stringr::str_replace("water_quality", "water_quality_available") %>%
          stringr::str_replace("aqua", "AquaChem") %>%
          stringr::str_replace_all("rems", "EMS") %>%
          stringr::str_replace_all("_", " ") %>%
          tools::toTitleCase()
      }) %>%
      DT::datatable(options = list(pageLength = 20, scrollX = TRUE),
                    rownames = FALSE)

  })

}