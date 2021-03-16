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

source("./dados.R")


ui <- fluidPage(
    
    includeCSS("./estilo.css"),
    
    titlePanel(h1("Peixes Marcados")),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Selecione a espécie desejada"),
            
            selectInput(inputId = "local_Selector", label = "Selecione o local", choices =  c("Todos", locais$nome_local)),
            
            checkboxGroupInput(inputId = "sp_CheckBox", label = "Selecione as espécies", choices = especies$id_especie, selected = "1")
            
        ),
        mainPanel(
            plotOutput("peso_comprimento")
        )
        
    )
)
