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
library(dplyr)
library(leaflet)
library(htmltools)

source("./dados.R")
source("./tema.R")

ui <- dashboardPage(

    dashboardHeader(
            titleWidth = 210,
            title = "Peixes Dashboard",
            
            tags$li(class = "dropdown",
                    tags$style(".main-header {max-height: 59px}"),
                    tags$style(".main-header .logo {height: 59px;}"),
                    tags$style(".sidebar-toggle {height: 59px; padding-top: 1px !important;}"),
                    tags$style(".navbar {min-height:59px !important}")
            ),         
            
                    tags$li(a(href = 'https://github.com/LeonardoDonatoNunes/PeixesMarcados_Shiny',
                              icon("github", "fa-2x"),
                              title = "Código fonte"),
                            class = "dropdown"),
                    tags$li(a(href = 'https://www.linkedin.com/in/leonardo-donato-nunes-754aa5b8/',
                              icon("linkedin", "fa-2x"),
                              title = "LinkedIn Leonardo"),
                            class = "dropdown")),
    
    
    
    
    dashboardSidebar(
      width = 250,
      
      HTML(paste0(
        "<br>",
        "<a href='http://www.neotropical.com.br/' target='_blank'><img style = 'display: block; margin-left: auto; margin-right: auto;' src='Logo_Cinza.png' width = '130'></a>",
        "<br>"
      )),
      
      selectInput(inputId = "local_Selector", label = "Selecione o local", choices =  c("Todos", locais$nome_local)),
      
        checkboxGroupInput(inputId = "sp_CheckBox",label = "Selecione as espécies", choiceNames = especies$especies, choiceValues = especies$id_especie, selected = "1")
      
    ),
    
    # $$$$$$$$$$$$$$$$ Corpo do dashboard $$$$$$$$$$$$$$$$$ ----
    
    dashboardBody(
      
      customTheme,
      
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "estilo.css")
      ),
      
      
      fluidRow(
        
        tabBox(width = 12,
          
          # @@@@@@@@@@@@@@@@@@@@@ Painel 1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          
          tabPanel(title = span(icon("calculator"), "Dados de contagens"),
            fluidRow(
              # A static valueBox
              valueBoxOutput("total_tab1", width = 4),
              
              # Dynamic valueBoxes
              valueBoxOutput("numero_proj", width = 4),
              
              valueBoxOutput("numero_esp", width = 4)
            ),
            
            fluidRow(
              column(8,
                     box(title = span(icon("globe-americas"),"Pontos de coleta"), solidHeader = TRUE,
                         leafletOutput("mapa",width = "100%",height = "400"), width = 12)),
              
              column(4,
                     box(title = span(icon("chart-bar"),"Número de peixes"), 
                         status = "primary", solidHeader = TRUE,
                         plotOutput("numero_individuos"), width = 12))
            )
            
          ),
          
          # @@@@@@@@@@@@@@@@@@@@@ Painel 2 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          
          tabPanel(title = span(icon("chart-pie"), "Dados biométricos"),
            
                   fluidRow(
                     # A static valueBox
                     valueBoxOutput("total_tab2", width = 4),
                     
                     # Dynamic valueBoxes
                     valueBoxOutput("media_comp", width = 4),
                     
                     valueBoxOutput("media_peso", width = 4)
                   ),
                          
            fluidRow(
              box(title = span(icon("chart-line",),"Relação Peso x Comprimento"), 
                  status = "primary", solidHeader = TRUE,
                  plotOutput("peso_comprimento"), width = 6),
              box(title = span(icon("chart-line",),"Boxplot dos comprimentos"), 
                  status = "primary", solidHeader = TRUE,
                  plotOutput("box_plot_comp"), width = 3),
              box(title = span(icon("chart-line",),"Boxplot dos pesos"), 
                  status = "primary", solidHeader = TRUE,
                  plotOutput("box_plot_pesos"), width = 3)
            )
          )
        )

  )
)
)