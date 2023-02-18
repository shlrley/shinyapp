library(shiny)

ui <- fluidPage(
  
  # title 
  titlePanel("Shiny app practice"),
  
  # sidebar for filtering
  sidebarLayout(
    sidebarPanel(
                # slider for choosing year
                sliderInput(inputId='bins',
                             label='Year Installed',
                             min=1950,
                             max=2022,
                             value=72),
                 # dropdown menu for choosing artist 
                 selectInput('artist', 
                             "Artist", 
                             choices = c('A', 'B', 'C')),
                 # checkboxes for choosing art type 
                 checkboxGroupInput('type', 'Art Type',
                                    c("Mural" = "mural",
                                      "Statue" = "statue",
                                      "Graffiti" = "graffiti")),
                 # checkboxes for choosing neighbourhood 
                 checkboxGroupInput('neighbourhood', 'Neighbourhood',
                                    c("Downtown" = "downtown",
                                      "Dunbar" = "dunbar",
                                      "Kerrisdale" = "kerrisdale")),
                # slider for the histogram
                sliderInput(inputId='slider',
                            label='Bins for histogram',
                            min=0,
                            max=10,
                            value=5 )),
    # main panel for the map 
    mainPanel(plotOutput(outputId = 'distplot')),
  )
)

server <- function(input, output, session){
 
   output$distplot <-  renderPlot({
    
    # generate bins 
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$slider + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
}

shinyApp(ui, server)
