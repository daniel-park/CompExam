library(shiny)
setwd("~/Dropbox/CSUEB/CompExam/RProgram")



part1 <- c("2010Nov_pt1-1", "2010Nov_pt1-2", 
           "2010Nov_pt1-3", "2010Nov_pt1-4",
           "2015May_pt1-1", "2015May_pt1-2",
           "2015May_pt1-3", "2015May_pt1-4", 
           "2015May_pt1-5")
part2 <- c("2010Nov_pt2-1", "2010Nov_pt2-2", 
           "2010Nov_pt2-3", "2010Nov_pt2-4")

exam.year <- c("2013", "2014", "2015")

exam.season<- c("Spring", "Fall")

exam.problem <- c("1", "2", "3", "4", "5")
  
  
ui <- fluidPage(
  title="Comprehensive Exam Practice", # Only seems to appear in web browser
  titlePanel("Comp Exam"),
  # Copy the line below to make a set of radio buttons
  sidebarPanel(radioButtons("radio_part", label=h4("Exam"), 
                            choices=list("Part I (closed book)"="part1", 
                                         "Part II (open book)"="part2"), 
                            selected=1),
               radioButtons("radio_season", label=h4("Season"), 
                           choices=list("Spring"="spring", 
                                        "Fall"="fall"), 
                           selected=1),
               selectInput("select_year",
                           "Year",
                           c("Select", exam.year)),
               selectInput("select_problem",
                           "Problem",
                           c("Select", exam.problem)),
#               conditionalPanel(condition="input.radio_part=='part1' & 
#                                input.radio_season=='spring' & 
#                                input.select_year=='2015' | 
#                                input.select_year=='2014' ",
#                                selectInput(inputId="exam_problem",
#                                            label="Problem",
#                                            choices=c("Select", exam.problem4))),
               actionButton(inputId="button_solution", label="Solution")
               ),
  mainPanel(
    htmlOutput(outputId="problem"),
  )
)








server <- function(input, output) {
  #part1.or.2 <- eventReactive(eventExpr=input$radio, handlerExpr={
  #  ifelse(input$radio==1, 1, 2)
  #})
  
  ntext <- eventReactive(input$button_solution, {
    if (input$radio_part=="part1") { part_str <- "pt1"}
    else if (input$radio_part=="part2") { part_str <- "pt2"}
    if (input$radio_season=="spring") { season_str <- "May"}
    else if (input$radio_season=="fall") { season_str <- "Nov"}
    year_str <- input$select_year
    problem_str <- input$select_problem
    paste0(year_str, season_str, "_", part_str, "-", problem_str, "sol.html")
  })
  output$problem <- renderUI(withMathJax(includeHTML( {ntext()} )))  
}

shinyApp(ui=ui, server=server)
