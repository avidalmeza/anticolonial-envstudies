server <- function(input, output){
  
  # Set reactive function
  filter_entries <- shiny::reactive({
    entries  |> 
      # Add checkboxGroupInput filter
      filter(year >= input$year[1] & year <= input$year[2]) |>
      # Add sliderInput filter
      filter(type %in% input$type)
    })
  
  output$mytable <- DT::renderDataTable({
    DT::datatable(filter_entries(),
                  rownames = FALSE,
                  colnames = c("Type", "Name", "Author", "ID type", "Identifer", "Year", "Tags"),
                  options = list(paging = TRUE, 
                                 pageLength = 5,
                                 autoWidth = TRUE,
                                 columnDefs = list(list(targets = c(1, 2), width = "350px")),
                                 scrollX = TRUE))
    })
  
  }