
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
            theme_bw(base_size = 20) +
            theme(legend.position = "top",
                  legend.title = element_blank(),
                  plot.background = element_rect(fill = "transparent",
                                                 colour = "transparent",
                                                 color = "transparent")) +
            xlab("Comprimento (cm)") +
            ylab("Peso (Kg)")
        
    }
    )
}