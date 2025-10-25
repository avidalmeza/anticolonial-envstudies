header <- shinydashboard::dashboardHeader(
  title = "Tools and topics for anticolonial environmental studies", titleWidth = 530)

sidebar <- shinydashboard::dashboardSidebar(disable = TRUE)

body <- shinydashboard::dashboardBody(
  
  includeCSS(here::here("www", "styles.css")), # Link stylesheet
  
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
    
    # Set sidebar panel
    column(width = 3,
           
           # checkboxGroupInput
           box(width = NULL, 
               checkboxGroupInput("type", label = "Select type(s):",
                                  choices = unique(entries$type),
                                  selected = c(unique(entries$type)))
               ),
           
           # sliderInput
           box(width = NULL, 
               sliderInput("year", label = "Select year(s):",
                           min = min(entries$year), max = max(entries$year),
                           value = c(min(entries$year), max(entries$year)), sep = "")
               )
           ),
    
    # Set main panel
    column(width = 9,
           box(width = NULL, DT::DTOutput("mytable", width = "100%"))
           )
    
    )
  )

shinydashboard::dashboardPage(header, sidebar, body)