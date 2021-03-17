

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
                                 selected = especies_obs$id_especie,
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
    
    output$mapa <- renderLeaflet({
        
        local <- input$local_Selector
        cores <- ifelse(locais$nome_local == local, "red", "navy")
        
        locais_esp <- sp::SpatialPointsDataFrame(coords = cbind(locais$lon, locais$lat), data = locais)
        
        n_local <- capturas %>% group_by(id_local) %>% count()
        locais_esp$numero_peixes <- (n_local$n/sum(n_local$n))*40
        
        
        leaflet(locais_esp) %>% addTiles() %>%
            addProviderTiles(providers$CartoDB.DarkMatter) %>%
            addCircleMarkers(
                label = ~htmlEscape(paste0(locais_esp$nome_local, " ", n_local$n)),
                radius = ~numero_peixes,
                color = cores,
                stroke = FALSE, fillOpacity = 0.5
            ) 
        
    })
    
    output$numero_individuos <- renderPlot({
        
        local <- input$local_Selector
        
        if(local == "Todos"){
            numero_ind <- capturas %>% 
                group_by(id_especie) %>% count() 
        }
        
        if(local != "Todos"){
            local_id <- locais[locais$nome_local == local,]$id_local
            
            numero_ind <- capturas %>% 
                filter(id_local == local_id) %>% 
                group_by(id_especie) %>% count() 
            
        }
        
        numero_ind <- merge(numero_ind, especies[,c("id_especie", "especies")], by = "id_especie")
        
        ggplot(data = numero_ind, aes(x = reorder(as.factor(especies), n), y = n, fill = as.factor(especies))) +
            geom_bar(stat = "identity", show.legend = F) +
            geom_text(aes(label = n), hjust = 1.2) +
            coord_flip() + 
            theme_classic(base_size = 20) +
            theme(plot.background=element_rect(fill = "black"),
                  panel.background = element_rect(fill = 'black'),
                  legend.background = element_rect(fill = "black", color = NA),
                  axis.text.x = element_blank(),
                  axis.ticks = element_blank())
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
            xlab("Espécies") +
            ylab("Comprimento (cm)")
    })
    
    output$box_plot_pesos <- renderPlot({
        
        ggplot(data = dados(), aes(x = as.factor(id_especie), y = peso)) +
            geom_boxplot() +
            theme_classic(base_size = 20) +
            theme(plot.background=element_rect(fill = "black"),
                  panel.background = element_rect(fill = 'black')) +
            xlab("Espécies") +
            ylab("Peso (Kg)")
    })
    
    output$total_tab1 <- renderValueBox({
        valueBox(
            paste0(nrow(dados())), "Peixes Marcados", icon = icon("fish"),
            color = "black"
        )
    })
    
    output$numero_proj <- renderValueBox({
        valueBox(
            nrow(locais), "Projetos",
            color = "black"
        )
    })
    
    output$numero_esp <- renderValueBox({
        valueBox(
            nrow(especies), "Número de Espécies",
            color = "black"
        )
    })
    
    output$total_tab2 <- renderValueBox({
        valueBox(
            paste0(nrow(dados())), "Peixes Marcados", icon = icon("fish"),
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