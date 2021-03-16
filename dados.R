# Cria os dados para o exemplo
set.seed(345)

n_observacoes <- 10000
erro <- rnorm(n_observacoes, mean = 0, sd = 0.5)

especies <- data.frame(id_especie = 1:10,
                       especies =  c("sp1", "sp2", "sp3", "sp4", "sp5", "sp6", "sp7", "sp8", "sp9", "sp10"), 
                       media_compr = c(56,35,55,46,29,34,76,44,21,20), 
                       sd_compr = c(8,6,7,7,6,6,5,5,4,4),
                       intersepto = c(1.2,0.8,1.3,1.1,0.6,0.8,2,1,0.5,0.4),
                       inclinacao = c(0.035,0.025,0.045,0.034,0.029,0.039,0.05,0.03,0.025,0.021))


locais <- data.frame(id_local = c(1,2,3,4), 
                     nome_local = c("Amazonas", "Parana", "Araguaia", "Uruguai"), 
                     lon = c(-59.535561,-51.962591,-50.856247,-52.381315), 
                     lat = c(-3.127810,-21.443008,-14.024564,-27.292688))


capturas <- data.frame(id_local = c(rep(1,n_observacoes/2), rep(2,n_observacoes/10), rep(3,n_observacoes/5), rep(4,n_observacoes/5)),
                       id_especie = c(sample(especies$id_especie[1:2], replace = T, size = n_observacoes/2, prob = c(60,40)),
                                      sample(especies$id_especie[3:4], replace = T, size = n_observacoes/10, prob = c(50,50)),
                                      sample(especies$id_especie[5:7], replace = T, size = n_observacoes/5, prob = c(60,20,20)),
                                      sample(especies$id_especie[7:10], replace = T, size = n_observacoes/5, prob = c(30,25,25,20))))

capturas <- capturas[order(capturas$id_especie),]

comprimentos <- NULL
pesos <- NULL
for(i in 1:length(especies$id_especie)){
  temp <-  rnorm(nrow(capturas[capturas$id_especie == especies$id_especie[i],]),mean = especies$media_compr[i], sd = especies$sd_compr[i])
  comprimentos <- c(comprimentos,temp) 
  
  pesos <- c(pesos,
             (temp^1.4)*especies$inclinacao[i] + especies$intersepto[i]) 
}

capturas$comprimento <- comprimentos
capturas$peso <- pesos + erro