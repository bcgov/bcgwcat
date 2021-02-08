library(shiny)
library(shinydashboard)
library(shinyjs)

styles <- "h4 {margin-left: 5px;}"

header <- dashboardHeader(title = "REMS to AquaChem")

sidebar <- dashboardSidebar(
  tags$head(tags$style(HTML(styles))),
  h4("Data options"),
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

  # Plot options
  h4("Plot options"),
  uiOutput("data_ids"),
  radioButtons("data_omit", strong("Omit 'bad' charge balances?"),
               choices = c("Yes" = TRUE, "No" = FALSE), inline = TRUE),
  radioButtons("legend", strong("Piper plot legend"),
               choices = c("Show" = TRUE, "Hide" = FALSE), inline = TRUE),

  # Help
  hr(),
  h4(a(icon("question"), "Help", href = "https://steffilazerte.ca/rems2aquachem/",
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

           tabPanel("Results",
                    shinyjs::disabled(downloadButton("download_csv_data", "Download to CSV")),
                    shinyjs::disabled(downloadButton("download_excel_data", "Download to Excel")),
                    DT::DTOutput("data")),

           tabPanel("Plots",
                    fluidRow(
                      column(width = 6,
                             box(width = NULL,
                                 downloadButton(outputId = "download_plots", label = "Download All Plots"),
                                 br(),
                                 "Note that downloaded plots may not have the same dimensions as the preview plots"),
                             box(title = "Stiff Plot", width = NULL,
                                 plotOutput("stiff", width = "100%", height = "350px"),
                                 strong("Note that Stiff plots only include complete samples"))
                      ),
                      column(width = 6,
                             box(title = "Piper Plot", width = NULL, height = "525px",
                                 plotOutput("piperplot"))
                      ))
                    ),
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
