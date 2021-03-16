
server <- function(input, output, session) {
    
    
    observe({
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        updateCheckboxGroupInput(session, "sp_CheckBox",
                                 label = paste0("Selecione as especies do ", local),
                                 choices = unique(dados$id_especie),
                                 selected = unique(dados$id_especie)[1],
        )
    })
    
    
    output$peso_comprimento <- renderPlot({
        
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados  = dados[dados$id_especie %in% especie,]
        
        ggplot(data = dados, aes(x = comprimento, y = peso, color = as.factor(id_especie))) +
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
        
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados  = dados[dados$id_especie %in% especie,]
        
        ggplot(data = dados, aes(x = as.factor(id_especie), y = comprimento)) +
            geom_boxplot() +
            theme_classic(base_size = 20) +
            theme(plot.background=element_rect(fill = "black"),
                  panel.background = element_rect(fill = 'black')) +
            xlab("Comprimento (cm)") +
            ylab("Peso (Kg)")
    })
    
    output$total <- renderPlot({
        
        
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados  = dados[dados$id_especie %in% especie,]
        
        
        ggplot(data = dados, aes(1,1)) +
            geom_text(aes(label = nrow(dados)), col = "white", size = 5) +
            theme_map() +
            theme(plot.background=element_rect(fill = "black"),
                  panel.background = element_rect(fill = 'black'))
    }, height = 100, width = 100)
    
    output$media_com <- renderPlot({
        
        
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados  = dados[dados$id_especie %in% especie,]
        
        
        ggplot(data = dados, aes(1,1)) +
            geom_text(aes(label = round(mean(dados$comprimento)),2), col = "white", size = 5) +
            theme_map() +
            theme(plot.background=element_rect(fill = "black"))
    }, height = 100, width = 100)
    
    output$media_peso <- renderPlot({
        
        
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados  = dados[dados$id_especie %in% especie,]
        
        
        ggplot(data = dados, aes(1,1)) +
            geom_text(aes(label = round(mean(dados$peso)),2), col = "white", size = 5) +
            theme_map() +
            theme(plot.background=element_rect(fill = "black"))
    }, height = 100, width = 100)
    
    output$total_2 <- renderPlot({
        
        
        local = input$local_Selector
        
        if(local == "Todos"){
            dados  = capturas
        }
        
        if(local != "Todos"){
            dados  = capturas[capturas$id_local %in% locais[locais$nome_local == local,]$id_local,]
        }
        
        especie = input$sp_CheckBox
        dados  = dados[dados$id_especie %in% especie,]
        
        
        ggplot(data = dados, aes(1,1)) +
            geom_text(aes(label = nrow(dados)), col = "white", size = 5) +
            theme_map() +
            theme(plot.background=element_rect(fill = "black"))
    }, height = 100, width = 100)
    
    
    
}
