library(shiny)

# Define UI for application demonstrates R package quantmod graph capabilities
shinyUI(
  navbarPage("R quantmod Demonstration for Data Products Class", inverse=FALSE,
             
   tabPanel("Documentation",
            fluidPage(
              verticalLayout(
                h2("How to use the R quantmod Demonstration App", align="center"),
                hr(),
                h3("Directions"),
                p("To get started using this application, you'll need to look at the banner line above titled \"R quantmod Demonstration for Data Products Class\" and click \"Demo\".  This will take you to the application itself.  You can click \"Documentation\" to return to this screen."),
                p("The application begins by displaying the stock symbol \"^DJI\" which represents the Dow Jones Industrial Average.  You can enter whatever stock symbol you would like (without the caret \"^\") and the graph will update accordingly.  If your stock symbol is not valid - no graph will display"),
                p("There are 3 other areas you can play with to change the current display for the selected stock:"),
                tags$ol(tags$li("Date Range - you can change the date range selected for the price display"),
                        tags$li("Chart Theme - you can change how the graph is diplayed by choosing a supported theme"),
                        tags$li("Add Optional Technical Analysis Overlays - you can add additional chart items that will calculate some industry analytics and overlay them on the existing chart.  Also a small warning here - some analytics require at least 3 months of data.  If you don't have at least 3 months of data selected in the date range - you may get an error in display of the graph.")),

                p("The graph will immediately respond to any changes you make.  Feel free to experiment and explore this application based on R, Shiny, and the quantmod package for R!"),
                br(),
                h3("About the App"),
                p("This application was written for the project in the Coursera course \"Developing Data Products\". It is an example of how to use the quantmod package within R, and what some of its capabilities are."),
                p("The app starts by providing a user interface that collects a stock symbol, date range, and optional analytics to perform on the provided stock symbol.  When anything changes in the user interface, the application reacts to the changes by updating the graphs calculated by the server code."),
                tags$ol(tags$li("Input"), tags$ul(tags$li("Stock Symbol - textInput()"), tags$li("Date Range - dateRangeInput()"), tags$li("Chart Theme - radioButtions()"), tags$li("Technical Analysis - checkBoxGroupInput()")),
                        tags$li("Operation/Calculation", tags$ul(tags$li("Call to getSymbols() to retrieve data"), tags$li("preparation of variables for graphic display"))), 
                        tags$li("Reactive Output"), tags$ul(tags$li("Call to render graph calculations within the quantmod libraries"), tags$li("Display of the rendered graph"))),
                hr(),
                h3("Application Source Code"),
                h4("ui.R"),
                pre(includeText("ui.R")),
                h4("server.R"),
                pre(includeText("server.R")),
                p("Note: Some code used in this demo is based on the Shiny quantmod tutorial but was not copied wholesale.  The work demonstrated above represents a significant departure from the tutorial.")
              )
            )
   ),
    tabPanel("Demo",
  
      fluidPage(
      
      # Application title
      #titlePanel("R quantmod Demonstration"),
      
      # Sidebar with inputs for quantmod graphing capabilities
      sidebarLayout(
        sidebarPanel(
          textInput("stock", "Enter a stock symbol", value = "^DJI", width = "30%"),
    #      submitButton(text="Get Stock Quote"),
          br(),
          dateRangeInput("dtRange", "Date Range", start = Sys.Date()-90, end = NULL, min = NULL, max = NULL, format = "yyyy-mm-dd", startview = "month", weekstart = 0, language = "en", separator = " to ", width = NULL),
          hr(),
          flowLayout(radioButtons("theme", "Chart Theme:",
                       c("White" = "white",
                         "White Mono" = "white.mono",
                         "Black" = "black",
                         "Black Mono" = "black.mono",
                         "Beige" = "beige",
                         "WSJ"= "wsj"
                         )),
                     checkboxGroupInput("ta", "Add Optional Technical Analysis Overlays:",
                                        c("Directional Movement Index" = "addADX()",
                                          "Average True Range" = "addATR()",
                                          "Bollenger Bands" = "addBBands()",
                                          "Commodity Channel Index" = "addCCI()",
                                          "Chaiken Money Flow" = "addCMF()",
                                          "Chande Momentum Oscillator" = "addCMO()",
                                          "Contract Expiration Bars" = "addExpiry()",
                                          "De-trended Price Oscillator" = "addDPO()",
                                          "Simple Moving Average" = "addSMA()",
                                          "Expotential Moving Average" = "addEMA()",
                                          "Weighted Moving Average" = "addWMA()",
                                          "Double Expotential Moving Average" = "addDEMA()",
                                          "Expotential Volume Weighted Moving Average" = "addEVWMA()",
                                          "ZLEMA" = "addZLEMA()",
                                          "Moving Average Convergence Divergence" = "addMACD()",
                                          "Price Envelope" = "addEnvelope()",
                                          "Relative Strength Index" = "addRSI()",
                                          "Parabolic Stop and Reversal Indicator" = "addSAR()",
                                          "Rate of Change" = "addROC()",
                                          "Stochastic Momemtum Indicator" = "addSMI()"
                                          ))
                     
            )
          ),
          # Show the demonstration plot
          mainPanel(
            plotOutput("distPlot", height="885px")
      #      ,textOutput("dispPrint")
          )
        )
      )
    )
  )
)
