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

header <- dashboardHeader(title = "BC GWCAT")


# Sidebar -----------------------------------------------------------------
sidebar <- dashboardSidebar(
  tags$head(tags$style(HTML(styles))),

  tags$h4("BC Groundwater Chemistry Analysis Tool", style = "padding:20px; padding-top:0; text-align:center;"),

  h4("Data options"),
  # Select EMS IDs
  textInput(inputId = "ems_ids",
            label = strong(
              "EMS IDs (Comma-separated)",
              actionLink("link_details4", label = icon("question"),
                         style = "display:inline;margin:0"))),

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
  h4(a(icon("question"), "Help", href = "https://bcgov.github.io/bcgwcat/articles/bcgwcat.html",
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

           # Data Status Tab ----------------------------------------------------------
           tabPanel(
             "Data Status",
             fluidRow(
               box(
                 width = 12,
                 h3("Status of local EMS data"),
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

           # Preview/Export Tab -------------------------------------------------------------
           tabPanel(
             "Preview/Export",

             box(
               width = 12,
               p("Here we have the selected EMS Data prepared for export, formatted for use in AquaChem."),
               tags$ul(
                 tags$li("Charge balances are highlighted as acceptable",
                         "(absolute value < 10; ",
                         span("green", style = "background-color:#d4edda", .noWS = "after"), ")",
                         "or not (absolute value > 10; ",
                         span("red", style = "background-color:#f8d7da", .noWS = "after"), ").",
                         "Please see ", actionLink("link_details1", "Details Tab"),
                         "for a note on how Charge Balances differ from those in the EMS data base."),
                 tags$li("Parameter names, ", em("and occasionally units,"),
                         "are different from those in the EMS data base.",
                         "Please see ", actionLink("link_details2", "Details Tab"), "for how they correspond.")
               ),
               shinyjs::disabled(downloadButton("download_csv_data", "Download to CSV")),
               shinyjs::disabled(downloadButton("download_excel_data", "Download to Excel")),
             ),

             fluidRow(
               box(width = 12, height = "100px", DT::DTOutput("data"))
             )),


           # Water Quality Tab -------------------------------------------------------
           tabPanel(
             "Water Quality Summary",
             fluidRow(
               box(
                 width = 2,
                 radioButtons(
                   "wq_show", strong("Samples to include:"),
                   choices = list("All" = "all",
                                  "Problems only" = "problems",
                                  "Non-missing only" = "no_missing"))),
               box(
                 width = 10,
                 uiOutput("data_params"),
                 actionButton("reset_params", "Select/Unselect All"),
                 p("Summarized Water Quality based to the 'Upper Limits' ",
                 "of the 'Maximum Acceptable Concentration' for 'Drinking Water'.",
                 "See", actionLink("link_details3", "Details Tab"), "for more specifics.",
                 style = "padding-top:20px"))),
             fluidRow(box(width = 12, height = "100px", DT::DTOutput("data_wq")))
           ),

           # Plots Tab ---------------------------------------------------------------
           tabPanel(
             "Plots",
             fluidRow(
               column(
                 width = 6,
                 box(
                   width = NULL,
                   downloadButton(outputId = "download_plots", label = "Download All Plots"),
                   p(),
                   p("Note that downloaded plots may not have the same dimensions as the preview plots"),
                   p("You can also Right-click on a plot and choose to save the image directly.",
                     "This will ensure the same dimensions and 'zoom' level as the display.")
                   ),
                 box(
                   title = "Stiff Plot", width = NULL,
                   plotOutput("stiff", width = "100%", height = "350px"),
                   strong("Note that stiff plots only include complete samples"))
               ),
               column(
                 width = 6,
                 box(
                   title = "Piper Plot", width = NULL, height = "525px",
                   plotOutput("piperplot"))
               ))
           ),

           # Details Tab -------------------------------------------------------------
           tabPanel(
             "Details",
             fluidRow(

               ## EMS IDs --------------
               box(
                 title = "EMS IDs", width = 12,
                 p("In order to download water chemistry data from the EMS database, ",
                   "you'll need to supply", em("public"), "EMS IDs, in the format of '1401030' or 'E292373'.",
                   "Because this app works with the publically available EMS data base, only public data",
                   "can be accessed. However, if you have private data you are able to mark as public,",
                   "it will then be accessible here")
               ),

               ## Charge Balances --------------
               box(
                 title = "Charge Balances", width = 12,
                 p("In the data, values `charge_balance`, `cation_sum` and `anion_sum` are calculated locally ",
                   "by the bcgwcat R package, based on calculation details from ALS Global. ",
                   "Potential changes in workflows over the years have made it difficult to ascertain exactly",
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
                   "values for cations or anions are missing the charge balance is NA.")
               ),

               ## Water Quality --------------
               box(
                 title = "Water Quality", width = 12,

                 p("Water Quality is summarized by whether parameters exceed '",
                   strong("Upper Limits", .noWS = "outside"), "' of the '",
                   strong("Maximum Acceptable Concentration", .noWS = "outside"),
                   "' for '", strong("Drinking Water", .noWS = "outside"), "' based on the",
                   a("Water Quality Guidelines of B.C.",
                     href = "https://catalogue.data.gov.bc.ca/dataset/85d3990a-ec0a-4436-8ebd-150de3ba0747",
                     target = "blank"),
                   "downloaded via the bcdata package.")
               ),

               ## Param Names --------------
               box(
                 title = "Parameter Names", width = 12,

                 p("The parameter names presented in the Preview/Export tab are modified from the EMS data",
                   "to match required parameter names for AquaChem."),
                 p("Here is the list of parameters used by this App and how the names compare between ",
                   "the incoming EMS data and the data prepared for export"),

                 DT::DTOutput("parameters")
               )


             ), footer = HTML("<br>")),

           # About Tab ---------------------------------------------------------------
           tabPanel(
             "About",
             fluidRow(
               box(
                 title = "About this Shiny App", width = 12,
                 p("This app allows functions the R package bcgwcat (BC Groundwater Chemistry Analysis Tools)",
                   "to be used in a simpler, and interactive format."),
                 p("BC Government Environmental Monitoring System (EMS) data is retrieved using the",
                   a('rems', href = "https://github.com/bcgov/rems", target = "_blank"),
                   "package and filtered. ",
                   "Data is filtered to the EMS IDs and the Date Range specified",
                   "and can then be exported for use in AquaChem, or",
                   "water quality summaries can be viewed, ",
                   "or piper and stiff plots can be created."),
                 p("Data can be downloaded for AquaChem as either csv or a colour-coded xlsx."),
                 p("Piper plots and stiff diagrams can be viewed and downloaded as png."),
                 p("Piper plots are created via the ",
                   a("smwrGraphs", href = "https://code.usgs.gov/water/analysis-tools/smwrGraphs"),
                   "package developed by Dave Lorenz and Laura DeCicco in the USGS")
               )

               ), footer = HTML("<br>"))
           )))

ui <- dashboardPage(header, sidebar, body)
