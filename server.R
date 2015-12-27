library(shiny)
library(quantmod)
options("getSymbols.warning4.0"=FALSE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates the stock chart plot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  sSymbol <- reactive({
    tryCatch({
      suppressWarnings(getSymbols(input$stock, from=input$dtRange[1], to=input$dtRange[2],
                                  auto.assign = FALSE))
    }, error = function(err) {
      return(NULL)
    })
  })

  output$distPlot <- renderPlot({
    taStr<-"addVo()"
    if (!is.null(input$ta)) {
      for (ta in input$ta) {
        taStr<-paste(taStr, paste(";", ta))
      }
    }
    
    if(!is.null(sSymbol())) {
      chartSeries(sSymbol(), name=input$stock, TA=taStr, theme=chartTheme(input$theme))
    }
  })
  
  output$dispPrint <- renderPrint({
    print(sSymbol())
  })
})
