#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggthemes)
library(shinydashboard)
library(dashboardthemes)

source("./dados.R")
source("./tema.R")

ui <- dashboardPage(

    dashboardHeader(
            titleWidth = 250,
            title = span(icon("fish"),"Peixes Marcados"),
                    tags$li(a(href = 'https://leonardodonatonunes.github.io/ds/',
                              img(src = 'Logo_Verde.png',
                                  title = "Leonardo Donato Nunes - Data Science", height = "30px"),
                              style = "padding-top:10px; padding-bottom:10px;"),
                            class = "dropdown")),
    
    dashboardSidebar(
      width = 250,
      selectInput(inputId = "local_Selector", label = "Selecione o local", choices =  c("Todos", locais$nome_local)),
      
        checkboxGroupInput(inputId = "sp_CheckBox", label = "Selecione as espécies", choiceNames = especies$especies, choiceValues = especies$id_especie, selected = "1")
      
    ),
    dashboardBody(
      
      customTheme,
      
      fluidRow(
        # A static valueBox
        valueBoxOutput("total", width = 4),
        
        # Dynamic valueBoxes
        valueBoxOutput("media_comp", width = 4),
        
        valueBoxOutput("media_peso", width = 4)
      ),
      
      
      fluidRow(
       box(title = "Relação Peso x Comprimento", status = "primary", solidHeader = TRUE,
                      "Box content here", br(), "More box content",
           plotOutput("peso_comprimento"), width = 8),
      box(title = "Boxplot dos pesos", status = "primary", solidHeader = TRUE,
                      "Box content here", br(), "More box content",
          plotOutput("box_plot_comp"), width = 4)
      )
    )
)