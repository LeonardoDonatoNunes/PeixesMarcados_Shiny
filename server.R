

server <- function(input, output, session) {
    
    observe({
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especies_obs <- especies[especies$id_especie %in% unique(dados$id_especie), ]
        
        updateCheckboxGroupInput(session, "sp_CheckBox",
                                 label = paste0("Selecione as especies do ", local),
                                 choiceNames = especies_obs$especies,
                                 choiceValues = especies_obs$id_especie,
                                 selected = especies_obs$id_especie[1],
        )
    })
    
    dados <- reactive({
        
        local <- input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados[dados$id_especie %in% especie,]
        
    })
    
    output$peso_comprimento <- renderPlot({
        
        ggplot(data = dados(), aes(x = comprimento, y = peso, color = as.factor(id_especie))) +
            geom_point() +
            geom_smooth() + 
            theme_classic(base_size = 20) +
            theme(legend.position = "top",
                  legend.title = element_blank(),
                  plot.background=element_rect(fill = "black"),
                  panel.background = element_rect(fill = 'black'),
                  legend.background = element_rect(fill = "black", color = NA),
                  legend.text = element_text(colour = '#474747')) +
            xlab("Comprimento (cm)") +
            ylab("Peso (Kg)")
        
    })
    
    output$box_plot_comp <- renderPlot({
    
        ggplot(data = dados(), aes(x = as.factor(id_especie), y = comprimento)) +
            geom_boxplot() +
            theme_classic(base_size = 20) +
            theme(plot.background=element_rect(fill = "black"),
                  panel.background = element_rect(fill = 'black')) +
            xlab("Comprimento (cm)") +
            ylab("Peso (Kg)")
    })
    
    output$total <- renderValueBox({
        valueBox(
            paste0(nrow(dados())), "Número de peixes marcados", icon = icon("fish"),
            color = "black"
        )
    })
    
    output$media_comp <- renderValueBox({
        valueBox(
            paste0(round(mean(dados()$comprimento),2)," cm"), "Média Comprimento", icon = icon("ruler-horizontal"),
            color = "black"
        )
    })
    
    output$media_peso <- renderValueBox({
        valueBox(
            paste0(round(mean(dados()$peso),2), " kg"), "Média Peso", icon = icon("weight-hanging"),
            color = "black"
        )
    })
    
}