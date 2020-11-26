library(shiny)
library(shinydashboard)
library(shinyjs)

header <- dashboardHeader(title = "REMS to AquaChem")

sidebar <- dashboardSidebar(
  # Select EMS IDs
  textInput(inputId = "ems_ids", label = strong("EMS IDs (Comma-separated)")),

  # Select date range
  dateRangeInput("date_range", strong("Date range"),
                 start = "1900-01-01", end = "2099-01-01",
                 min = "1900-01-01", max = "2099-01-01"),

  # Select data to show
  radioButtons("data_show", strong("Data to preview"),
               choices = list("Relevant Columns" = "rel", "All Columns" = "all")),

  # Get Data
  actionButton("get_data", "Get and convert EMS data"),

  hr(),
  p("This ShinyApp collects EMS data from BCGOV using the 'rems' package. Data is filtered to the EMS IDs and the Date Range specificied and is then formated for easy input into AquaChem."),
  p("Data can be downloaded as either csv or a colour-coded xlsx.")
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
    tabBox(title = NULL, width = 12,

           tabPanel("REMS Status",
                    fluidRow(
                      h3("Status of REMS data"),
                      valueBoxOutput("rems_status_recent", width = 4),
                      valueBoxOutput("rems_status_historic", width = 4),
                      actionButton("check_status", "Check status"), br(),
                      actionButton("update_recent", "Update recent data (2yr)"), br(),
                      actionButton("update_historic", "Update historic data")),
                    fluidRow(
                      h3("Data Messages"),
                      verbatimTextOutput("messages", placeholder = TRUE))),

           tabPanel("Results",
                    shinyjs::disabled(downloadButton("download_csv_data", "Download to CSV")),
                    shinyjs::disabled(downloadButton("download_excel_data", "Download to Excel")),
                    DT::DTOutput("data")),

           tabPanel("Plots",
                    uiOutput("data_ids"),
                    strong("Note that Stiff plots only include complete samples"),
                    br(),
                    downloadButton(outputId = "download_plots", label = "Download All Plots"),
                    plotOutput("piperplot", width = "900px", height = "500px"))

    ), footer = HTML("<br>"))
)

ui <- dashboardPage(header, sidebar, body)
