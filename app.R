library(shiny)
library(reticulate)


# use_python('/usr/bin/python3')
source('utils/draw_map.R')

ui <- fluidPage(
  titlePanel('PRTS-PlayW', windowTitle = 'PRTS-PlayW'),
  
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(
        type = 'tabs',
        tabPanel(
          'Stage',
          textInput('stage', 'Stage'),
          radioButtons(
            'dfct', 'Difficulty',
            choices = list('None', 'Challenge', 'Story', 'Ordeal'),
            selected = 'None')
        ),
        tabPanel(
          'Steps',
          textOutput('tile'),
          radioButtons(
            'action', 'Action',
            choices = list('Deploy', 'Withdraw', 'Activate'),
            selected = 'Deploy'),
          textInput('oprt', 'Operator'),
          selectInput(
            'direction', 'Direction',
            choices = list('East', 'South', 'West', 'North'),
            selected = 'East'),
          actionButton('add', 'Add')
        )
      )
    ),
    
    mainPanel(
      plotOutput("map", click = "map_click"),
      verbatimTextOutput("info")
    )
  )
)

server <- function(input, output) {
  output$map <- renderPlot({
    draw_map('1-7')
  })
  
  output$tile <- renderText({
    paste0("\nx=", input$map_click$x, "\ny=", input$map_click$y)
  })
}

shinyApp(ui, server)