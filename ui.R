# Define header
header <- shinydashboard::dashboardHeader(
  title = "Tools and Topics for Anticolonial Environmental Studies", titleWidth = 530)

# Define sidebar 
sidebar <- shinydashboard::dashboardSidebar(disable = TRUE)

# Define body
body <- shinydashboard::dashboardBody(
  # Link stylesheet
  includeCSS(here::here("www", "styles.css")),
  # Add about content
  fluidRow(
    column(width = 8,
           box(width = NULL,
               includeMarkdown(here::here("text", "about.md")))
           ),
    column(width = 4,
           box(width = NULL,
               includeMarkdown(here::here("text", "contact.md")))
    )),
  fluidRow(
    # Define sidebar panel
    column(width = 3,
           # Add checkboxGroupInput
           box(width = NULL, 
               shiny::checkboxGroupInput("type", label = "Select Type(s):",
                                         choices = unique(entries$type),
                                         selected = c("Web Text", "Journal Article", "Video", "Book", "Audio", "Writing Reference"))), 
           # Add sliderInput
           box(width = NULL, 
               sliderInput("year", label = "Select Year(s):",
                           min = min(entries$year), max = max(entries$year),
                           value = c(2000, 2023), sep = ""))
           ),
    # Define main panel
    column(width = 9,
           box(width = NULL, DT::DTOutput("mytable", width = "100%"))
           )
    )
  )

# Define user interface
shinydashboard::dashboardPage(header, sidebar, body)