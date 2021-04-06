# Peixes Dashboard

A aplicação está disponível em:

https://leonardodonatonunes.shinyapps.io/PeixesMarcados_Shiny/

Esta aplicação Shiny foi desenvolvida como um modelo para acompanhar projetos de marcação de peixes.

Os dados usados foram invetados, a criação dos dadoss está no script **dados.R**.

As visualizações e as entradas (inputs) foram escolhidos apenas para demostrar o funcionamento do aplicativo. 

O funcionamento do aplicativo pode ser visto no GIF abaixo:

<img src="www/Shiny_app.gif" alt="Neotropical Consultoria Ambiental" width = "700"> 


## Pacotes
```r
library(shiny)
library(ggplot2)
library(ggthemes)
library(shinydashboard)
library(dashboardthemes)
library(dplyr)
library(leaflet)
library(htmltools)
```
