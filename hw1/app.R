# Libraries
library(shiny)
library(ggplot2)

# Set variable for plot
petal.l <-  as.character(unique(iris$Petal.Length))
names(petal.l) <- petal.l


# Define UI for application 
ui <- navbarPage("Iris Time",
                 # Plot navbar, which isn't particularily meaningful, but it does run
                 tabPanel("Plot",
                          sidebarLayout(
                            sidebarPanel(
                              selectInput('Petal.Length','Petal.Length',choices = petal.l)
                              
                            ),
                            mainPanel(
                            plotOutput('distPlot')  
                            )
                          ) 
                 ),
                 # Table navbar
                 tabPanel("Table",
                          DT::dataTableOutput("table")
                 ),
                 # Input navbar because I needed another input but unfortunately don't have time to develop this further
                 tabPanel("Input",
                          checkboxGroupInput("checkGroup", label = h3("Iris Petals"), 
                                             choices = list("Length" = 1, "Width" = 2, "Species" = 3),
                                             selected = 1),
                          
                          
                          hr(),
                          fluidRow(column(3, verbatimTextOutput("value")))
                          
                 )
)
  
# Define server logic
server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    newdata <- subset(iris, iris$Petal.Length==input$Petal.Length)
    ggplot(newdata, aes(x=Sepal.Width)) + geom_histogram(fill = "steelblue")
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(iris)
  })
  
  output$value <- renderPrint({ input$checkGroup 
  })
}

# Run the application 
shinyApp(ui = ui, server = server)