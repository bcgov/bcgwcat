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
           tabPanel(
             "REMS Status",
             fluidRow(
               box(
                 width = 12,
                 h3("Status of REMS data"),
                 column(
                   width = 4,
                   valueBoxOutput("rems_status_historic", width = 12),
                   box(width = 12,
                       "Historical data is now being updated daily. ",
                       "However this is such a large download you may not want to update it everyday."),
                 ),
                 column(
                   width = 4,
                   valueBoxOutput("rems_status_recent", width = 12),
                   box(width = 12, "Consider updating recent EMS Data if it is out of date.")
                 ),
                 column(
                   width = 4,
                   actionButton("check_status", "Check status"), br(),
                   actionButton("update_recent", "Update recent data (2yr)"), br(),
                   actionButton("update_historic", "Update historic data"))
                 )),
               fluidRow(
                      box(h3("Data Messages"), width = 12,
                          verbatimTextOutput("messages", placeholder = TRUE)))),

           # Results Tab -------------------------------------------------------------
           tabPanel("Results",
                    shinyjs::disabled(downloadButton("download_csv_data", "Download to CSV")),
                    shinyjs::disabled(downloadButton("download_excel_data", "Download to Excel")),
                    fluidRow(
                      box(h4("Charge balances"),
                          "`charge_balance`, `cation_sum` and `anion_sum` are values calculated locally by the rems2aquachem R package, based on calculation details from ALS Global. Potential changes in workflows over the years have made it difficult to ascertain exactly how charge balances were calculated in older samples. This resulted in discrepancies between EMS and locally calculated charge balances. Therefore for consistency, we re-calculate charge balances for all samples using the formula provided by ALS (see About Tab for details).", width = 12)),
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
           tabPanel(
             "About",
             fluidRow(
               box(title = "About this Shiny App", width = 12,
                   p("This Shiny App collects EMS data from BCGOV using the",
                     a('rems', href = "https://github.com/bcgov/rems", target = "_blank"),
                     "package. ",
                     "Data is filtered to the EMS IDs and the Date Range ",
                     "specificied and is then formated for easy input into AquaChem."),
                   p("Data can be downloaded as either csv or a colour-coded xlsx."),
                   p("Piper plots and stiff diagrams can be viewed and downloaded as png.")),
               box(title = "About charge balances", width = 12,
                   p("Potential changes in workflows over the years have made it difficult to ascertain exactly",
                     "how charge balances were calculated in older samples. This resulted in",
                     "discrepancies between EMS and locally calculated charge balances. Therefore",
                     "for consistency, we calculate charge balances for all samples using the ALS",
                     "formula below."),

                   p("One difference between this calculation and that of ALS, is that we use more",
                     "significant digits when calculating MEQ."),
                   p("anion sum = Cl_meq + SO4_meq + F_meq + NO3_meq + NO2_meq + Means_Alk_meq"),

                   p("cation sum = Ca_meq + Mg_meq + Na_meq + K_meq + Al_diss_meq +",
                     "Cu_diss_meq + Fe_diss_meq + Mn_diss_meq + Zn_diss_meq + NH4_meq +",
                     "(10 ^ (-pH_lab)) * 1000"),

                   p("Charge balance = 100 x (Cation Sum - Anion sum) / (Cation Sum + Anion Sum)"),

                   p("Missing values are ignored (ie. generally treated as 0). However, if all",
                     "values for cations or anions are missing the charge balance is NA."))

               ), footer = HTML("<br>"))
           )))

ui <- dashboardPage(header, sidebar, body)
