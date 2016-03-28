library(shiny)
setwd("~/Dropbox/CSUEB/CompExam/RProgram")





part1 <- c("2010Nov_pt1-1", "2010Nov_pt1-2", 
           "2010Nov_pt1-3", "2010Nov_pt1-4",
           "2015May_pt1-1", "2015May_pt1-2",
           "2015May_pt1-3", "2015May_pt1-4", 
           "2015May_pt1-5")
part2 <- c("2010Nov_pt2-1", "2010Nov_pt2-2", 
           "2010Nov_pt2-3", "2010Nov_pt2-4")

ui <- fluidPage(
  title="Comprehensive Exam Practice", # Only seems to appear in web browser
  titlePanel("Comp Exam"),
  # Copy the line below to make a set of radio buttons
  sidebarPanel(radioButtons("radio", label = h4("Select Exam"), 
                            choices=list("Part I (closed book)"="part1", 
                                         "Part II (open book)"="part2"), 
                            selected=1),
               dateRangeInput(inputId="dates", 
                              label=h4("Date range"), 
                              format="yyyy"),
               actionButton(inputId="nextProblem", label="Next Problem")),
  mainPanel(
    tabsetPanel(
      tabPanel(title="Problem", htmlOutput(outputId="problem")),
      tabPanel(title="Solution", htmlOutput(outputId="solution"))
      ),
    fluidRow(column(3, verbatimTextOutput("value") ) ),
    fluidRow(column(3, verbatimTextOutput("year") ) )
    #withMathJax(), #if you want multiple lines of latex
    #verbatimTextOutput("nText"),
     #fluidRow may not do anything
    #uiOutput(outputId='ex1')
    #uiOutput('ex2')
  )
)


server <- function(input, output) {
  #part1.or.2 <- eventReactive(eventExpr=input$radio, handlerExpr={
  #  ifelse(input$radio==1, 1, 2)
  #})
  
  ntext <- eventReactive(input$nextProblem, {
    if (input$radio=="part1") {
      sample(x=part1, size=1)
    } else {
      sample(x=part2, size=1)
    }
    #sample(x=part1, size=1)
  })
  
  output$value <- renderPrint({ input$radio })
  output$year <- renderPrint({ format(input$dates, "%Y") })
  output$problem <- renderUI(withMathJax(includeHTML( {paste0(ntext(), "prob.html")} )))
  output$solution <- renderUI(withMathJax(includeHTML( {paste0(ntext(), "sol.html")} )))  
}

shinyApp(ui=ui, server=server)




