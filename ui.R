books_list <- readRDS(file = "book_list.rds")

library(shiny)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application Title
    headerPanel(" Book Recommender"),
    hr(),
    # Sidebar with a slider input for number of bins
    fluidRow(
        column(3,
              h3("Select Books you have read Till Now"),
            wellPanel(
                selectInput('book1','Book1',c('none',books_list$name)),
                selectInput('book2','Book2',c('none',books_list$name)),
                selectInput('book3','Book3',c('none',books_list$name)),
                selectInput('book4','Book4',c('none',books_list$name)),
                selectInput('count','Number of Suggestions',c(1:10)),
                actionButton('sub','Submit')
            )
        ),
        column(9,
               h3("Other Books you might Like"),
               h4("NOTE: not all combination of books return suggestions and some may include NA"),
               tableOutput("myout"),
               #imageOutput("new")
               plotOutput('new')
            )
        )
    )
)
