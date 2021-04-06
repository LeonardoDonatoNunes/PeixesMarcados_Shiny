# Peixes Dashboard

A aplicação está disponível em:

https://leonardodonatonunes.shinyapps.io/PeixesMarcados_Shiny/

Esta aplicação Shiny foi desenvolvida como exemplo de um modelo para acompanhar projetos de marcação de peixes.

Os dados usados foram invetados, o passo a passo da criação dos dados pode ser vista no arquivo **dados.R**.

As visualizações e as entradas (inputs) foram escolhidos apenas para demostrar o funcionamento do aplicativo. 

O funcionamento do aplicativo pode ser visto no GIF abaixo:

<p align="center">

<img src="www/Shiny_app.gif" alt="Aplicação Shiny" width = "700"> 

</p>

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
