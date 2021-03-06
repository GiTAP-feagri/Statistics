'----------------------------- DESCRI��O ---------------------------------------
                Autor: Prof. Lucas Amaral - FEAGRI/UNICAMP

Esta rotina calcula correla��o simples entre vari�veis, plota gr�fico de 
dispers�o e calcula regress�o linear por fun��es default do R.

-------------------------------------------------------------------------------'

# Limpar area de trabalho
rm(list = ls())
gc(reset=T)
graphics.off()

# selecionando diret�rio de trabalho, usando o diret�rio onde a rotina est� salva
if (!require("rstudioapi")) install.packages("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# carregar pacotes por meio do pacote pacman, que instala caso o mesmo ainda n�o o tenha sido
if (!require("pacman")) install.packages("pacman")
pacman::p_load(gstat, hydroGOF, rgdal, sp, raster, PerformanceAnalytics, GGally, corrplot, fBasics, dplyr, sf)

# carregar dados 
#Vamos usar dados simulados aqui
mean <- rep(0,4)
cov_matrix <- matrix(.7, nrow=4, ncol=4) + diag(4)*.3
dados <- data.frame(mvrnorm(n=10000, mu=mean, Sigma=cov_matrix))

# plotar gr�fico de dispers�o
plot(dados$X1, dados$X2) 

# correla��o de spearman
cor(dados, use="complete.obs", method="spearman")

# plotar gr�fico de dispers�o
lm_sph = lm(dados$X1 ~ dados$X2) # y em fun��o de x
abline(lm_sph, col = "red", lwd = 2) # linha da correla��o
r2_sph = summary(lm_sph)$r.squared # extrai R2

# op��es de gr�ficos mais completos
#1
corrplot::corrplot(cor(dados), method = "color", addCoef.col="grey")
#2
PerformanceAnalytics::chart.Correlation(dados, method="pearson", histogram=TRUE)
#3
GGally::ggpairs(dados)
