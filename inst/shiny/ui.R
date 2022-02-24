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

library(shiny)
library(shinydashboard)
library(shinyjs)

styles <- "h4 {margin-left: 5px;}"

header <- dashboardHeader(title = "REMS to AquaChem")


# Sidebar -----------------------------------------------------------------
sidebar <- dashboardSidebar(
  tags$head(tags$style(HTML(styles))),
  h4("Data options"),
  # Select EMS IDs
  textInput(inputId = "ems_ids", label = strong("EMS IDs (Comma-separated)")),

  # Select date range
  dateRangeInput("date_range", strong("Date range"),
                 start = "1900-01-01", end = "2099-01-01",
                 min = "1900-01-01", max = "2099-01-01"),

  # Get Data
  actionButton("get_data", "Get and convert EMS data"),

  hr(),

  h4("Preview options"),

  # Select data to show
  radioButtons("data_show", strong("Data to preview"),
               choices = list("Relevant Columns" = "rel", "All Columns" = "all")),

  # Charge balance to use
  radioButtons("data_charge_balance", strong("Charge balance to use"),
               choices = list("EMS calculation" = "charge_balance",
                              "rems2aquachem calculation" = "charge_balance2")),

  hr(),


  # Plot options
  h4("Plot options"),
  uiOutput("data_ids"),
  radioButtons("data_omit", strong("Omit 'bad' charge balances?"),
               choices = c("Yes" = TRUE, "No" = FALSE), inline = TRUE),
  radioButtons("legend", strong("Plot legends"),
               choices = c("Show" = TRUE, "Hide" = FALSE), inline = TRUE),

  # Help
  hr(),
  h4(a(icon("question"), "Help", href = "https://bcgov.github.io/rems2aquachem/",
       target = "_blank"))
)


body <- dashboardBody(
  shinyjs::useShinyjs(),
  tags$head(
    tags$style(HTML("
      .shiny-output-error-validation {
        color: green;
        font-size: 150%;
        padding-bottom: 20px;
      }
    "))
  ),

  fluidRow(
    tabBox(title = NULL, width = 12, id = "box",

           # REMS Status Tab ----------------------------------------------------------
           tabPanel("REMS Status",
                    fluidRow(
                      box(width = 12,
                          h3("Status of REMS data"),
                          valueBoxOutput("rems_status_historic", width = 4),
                          valueBoxOutput("rems_status_recent", width = 4),
                          actionButton("check_status", "Check status"), br(),
                          actionButton("update_recent", "Update recent data (2yr)"), br(),
                          actionButton("update_historic", "Update historic data")),
                      box("Historical data is now being updated daily. ",
                          "However this is such a large download you may not want to update it everyday.",
                          width = 4),
                      box("Recent EMS Data will need to be updated when ever it is out of date.",
                          width = 4)),
                    fluidRow(
                      box(h3("Data Messages"), width = 12,
                          verbatimTextOutput("messages", placeholder = TRUE)))),

           # Results Tab -------------------------------------------------------------
           tabPanel("Results",
                    shinyjs::disabled(downloadButton("download_csv_data", "Download to CSV")),
                    shinyjs::disabled(downloadButton("download_excel_data", "Download to Excel")),
                    fluidRow(
                      box(h4("Charge balances"),
                          "`charge_balance`, `cation_sum` and `anion_sum` are values provided by EMS,",
                          "whereas `charge_balance2`, `cation_sum2` and `anion_sum2` are values calculated locally by the rems2aquachem R package, based on details from ALS Global. As they are qualitatively but not quantitatively the same, we provide both so users can chose which they prefer", width = 12)),
                    DT::DTOutput("data")),


           # Water Quality Tab -------------------------------------------------------
           tabPanel("Water Quality Summary",
                    fluidRow(box(width = 2,
                                 radioButtons(
                                   "wq_show", strong("Samples to include:"),
                                   choices = list("All" = "all",
                                                  "Problems only" = "problems",
                                                  "Non-missing only" = "no_missing"))),
                             box(width = 10, uiOutput("data_params"),
                                 actionButton("reset_params", "Select/Unselect All"))),
                    fluidRow(DT::DTOutput("data_wq"))),

           # Plots Tab ---------------------------------------------------------------
           tabPanel("Plots",
                    fluidRow(
                      column(width = 6,
                             box(width = NULL,
                                 downloadButton(outputId = "download_plots", label = "Download All Plots"),
                                 br(),
                                 "Note that downloaded plots may not have the same dimensions as the preview plots"),
                             box(title = "Stiff Plot", width = NULL,
                                 plotOutput("stiff", width = "100%", height = "350px"),
                                 strong("Note that plots only include complete samples"))
                      ),
                      column(width = 6,
                             box(title = "Piper Plot", width = NULL, height = "525px",
                                 plotOutput("piperplot"))
                      ))
           ),

           # About Tab ---------------------------------------------------------------
           tabPanel("About",
                    fluidRow(
                      box(title = "About this Shiny App", width = 12,
                        p("This Shiny App collects EMS data from BCGOV using the",
                          a('rems', href = "https://github.com/bcgov/rems", target = "_blank"),
                          "package. ",
                          "Data is filtered to the EMS IDs and the Date Range ",
                          "specificied and is then formated for easy input into AquaChem."),
                        p("Data can be downloaded as either csv or a colour-coded xlsx."),
                        p("Piper plots and stiff diagrams can be viewed and downloaded as png."))
                    ), footer = HTML("<br>"))
    )))

ui <- dashboardPage(header, sidebar, body)
