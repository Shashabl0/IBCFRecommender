past_item_list <- readRDS("RDS/item_list.rds")
item_list <- as.data.frame(readRDS("RDS/master_book_list.rds"))
books1 <- as.data.frame(read.csv("RDS/books1.csv"))
source("AddVisualFunc.R")
source("cf_algorithm.R")
source("CosineSimilarity.R")
library(shiny)
library(tidyverse)
library(imager)
library(grid)
library(gridExtra)
shinyServer(function(input, output) {
    observeEvent(input$sub,{
            cread_books <- isolate(
                unique(c(item_list$ISBN[item_list$Title == input$book1],
                         item_list$ISBN[item_list$Title == input$book2],
                         item_list$ISBN[item_list$Title == input$book3],
                         item_list$ISBN[item_list$Title == input$book4]
                         ))
            )
            
            recom_cf_item = item_recommendation(sample(cread_books,1))
            recom_cf_item = recom_cf_item %>% left_join(books1, by = c("ISBN" = "ISBN")) 
            ##-----------------##
            nrecom <- input$count
            ## ----------------##
            isolate(
              downloadimg(recom_cf_item[!is.na(recom_cf_item$Book.Title),],"ISBN","Image.URL.M",nrecom)
            )
            new_table <- as.data.frame(recom_cf_item[1:nrecom,c(1,4,5,6)])
            #new_table <- new_table[complete.cases(new_table),]
            countt <- nrow(recom_cf_item[!is.na(recom_cf_item$Book.Title),])
            output$myout <- renderTable({
                new_table
                })
            dir = "IBCF_images"
            ## ----------------##
            output$new <- renderPlot({
                filename <- normalizePath(paste0("IBCF_images/",list.files("IBCF_images"))) # you had one extra space before .png
                filename <- filename[file.exists(filename)]
                jpg = lapply(filename, readJPEG)
                asGrobs = lapply(jpg, rasterGrob)
                p <- grid.arrange(grobs=asGrobs, nrow = 1)
            }, width = 1000)
        }
    )
    }
)

