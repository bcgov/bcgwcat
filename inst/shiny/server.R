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
library(rems2aquachem)
library(patchwork)

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
          rems::download_historic_data(force = FALSE, ask = FALSE)
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
    cache_historic <- rems::get_cache_date("historic")
    status$check_rems_historic <- FALSE
    Sys.Date() == lubridate::as_date(cache_historic)
  })


  # Output recent status
  output$rems_status_recent <- renderValueBox({
    dt <- rems::get_cache_date("2yr")
    if(dt == -Inf) dt <- "never" else dt <- as.character(lubridate::as_date(dt))
    valueBox(value = if(!rems_status_recent()) "Out-of-date" else "Up-to-date",
             subtitle = paste0("Recent EMS Data (last updated: ", dt, ")"),
             color = if(!rems_status_recent()) "red" else "green"
    )
  })

  # Output historic status
  output$rems_status_historic <- renderValueBox({
    cache <- rems::get_cache_date("historic")
    dt <- trunc(difftime(Sys.Date(), cache, units = "days"))
    if(dt == Inf) dt <- "never" else dt <- paste0(dt, " days ago")
    valueBox(value = if(!rems_status_historic()) "Out-of-date" else "Up-to-date",
             subtitle = paste0("Historic EMS Data (last updated: ", dt, ")"),
             color = if(!rems_status_historic()) "blue" else "green"
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

    if(any(class(r) == "try-error")) r <- NULL
    shinyjs::html(id = "messages", html = "EMS data received - Go to Results Tab to explore",
                   add = TRUE)

    r
  })

  data_plot <- reactive({
    req(data_ac())
    if(input$data_omit) {
      dplyr::bind_rows(data_ac()[1,],
                       dplyr::filter(data_ac()[-1,],
                                     abs(as.numeric(.data$charge_balance)) < 10))
    } else data_ac()
  })

  output$data <- DT::renderDT({
    validate(need(class(data_ac()) != "try-error",
                  message = data_ac()[1]))
    req(input$data_show)

    d <- data_ac()
    units <- dplyr::bind_cols(d[1, ])
    d <- d[-1,]

    if(input$data_show == "rel"){
      d <- d[, c("StationID", "SampleID", "Sample_Date",
                 "Ca", "Mg", "Na", "Cl", "HCO3", "SO4",
                 "Ca_meq", "Mg_meq", "Na_meq", "Cl_meq", "HCO3_meq", "SO4_meq",
                 "cations", "anions", "charge_balance")]

    }
    d <- dplyr::select(d, "StationID", "SampleID", "Sample_Date", "cations",
                       "anions", "charge_balance", dplyr::everything())

    col_names <- paste(colnames(d), units[colnames(d)], sep = "\n")

    DT::datatable(d, options = list(pageLength = 20, scrollX = TRUE),
                  colnames = col_names,
                  rownames = FALSE) %>%
      DT::formatRound(columns = c("Ca_meq", "Mg_meq", "Na_meq", "Cl_meq",
                                  "SO4_meq", "HCO3_meq", "cations",
                                  "anions", "charge_balance")) %>%
      DT::formatStyle("charge_balance",
                      backgroundColor = DT::styleInterval(cuts = c(-10, 10),
                                                          values = c("#f8d7da", "#d4edda", "#f8d7da")))
  })



# Dynamic inputs ----------------------------------------------------------
# Ems IDs for plots
  output$data_ids <- renderUI({
    req(data_ac())
    d <- data_ac()
    ids <- unique(stringr::str_extract(d$SampleID[-1], "^[0-9A-Z]+"))
    selectInput("ids_to_plot",
                "EMS IDs to plot (click to add or click/DELETE to remove)",
                ids, multiple = TRUE, selected = ids)
  })

# Plots -------------------------------------------------------------
  plot_msg <- "No data to plot\n\nPick a different set of EMS IDs or allow samples with 'bad charge balances' (see left-hand panel)"
  output$stiff <- renderPlot({
    req(data_plot(), input$ids_to_plot)
    validate(need(nrow(data_plot()) > 1, message = plot_msg))
    stiff_plot(data_plot(), ems_id = input$ids_to_plot, legend = as.logical(input$legend))
  })

  output$piperplot <- renderPlot({
    req(data_plot(), input$ids_to_plot)
    validate(need(nrow(data_plot()) > 1, message = plot_msg))
    piper_plot(data_plot(), ems_id = input$ids_to_plot, point_size = 0.15,
               legend = input$legend)
  }, width = 550, height = 500)



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




  # Download plots ----------------------------------------------------------
  output$download_plots <- downloadHandler(
    filename = function() {
      paste0("plots_", Sys.Date(), ".zip")
    },
    content = function(fname) {
      req(input$ids_to_plot)
      validate(need(nrow(data_plot()) > 1, message = "No plots to download"))
      tempdir <- tempdir()
      d <- data_plot()
      nm <- glue::glue_collapse(input$ids_to_plot, sep = "_")

      ratio <- 2 / length(input$ids_to_plot)

      f <- file.path(tempdir, glue::glue("{nm}_{c('stiff', 'piperplot')}.png"))
      ggplot2::ggsave(f[1],
                      stiff_plot(d, ems_id = input$ids_to_plot,
                                 legend = as.logical(input$legend)),
                      dpi = 300, width = 8, height = 5 * ratio)

      png(f[2], width = 2250, height = 2250, res = 300)
      piper_plot(d, ems_id = input$ids_to_plot,
                 point_size = 0.2, legend = input$legend)
      dev.off()

      zip(zipfile = fname, files = f, flags = "-j")
    }, contentType = "application/zip"
  )

}