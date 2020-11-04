# DESCRIÇÃO 


Autor: Prof. Lucas Amaral - FEAGRI/UNICAMP

Esta rotina calcula correlação simples entre variáveis, plota gráfico de 
dispersão e calcula regressão linear por funções default do R.

# Limpar area de trabalho

```{r}
rm(list = ls())
gc(reset=T)
graphics.off()
```
# selecionando diretório de trabalho, usando o diretório onde a rotina está salva
```{r}
if (!require("rstudioapi")) install.packages("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

```

# carregar pacotes por meio do pacote pacman, que instala caso o mesmo ainda não o tenha sido
```{r}
if (!require("pacman")) install.packages("pacman")
pacman::p_load(gstat, hydroGOF, rgdal, sp, raster, PerformanceAnalytics, GGally, corrplot, fBasics, dplyr, sf)
```

# carregar dados 
#Vamos usar dados simulados aqui
```{r}
mean <- rep(0,4)
cov_matrix <- matrix(.7, nrow=4, ncol=4) + diag(4)*.3
dados <- data.frame(mvrnorm(n=10000, mu=mean, Sigma=cov_matrix))
```

# plotar gráfico de dispersão
```{r}
plot(dados$X1, dados$X2) 
```

# correlação de spearman
```{r}
cor(dados, use="complete.obs", method="spearman")
```

# plotar gráfico de dispersão
```{r}
lm_sph = lm(dados$X1 ~ dados$X2) # y em função de x
abline(lm_sph, col = "red", lwd = 2) # linha da correlação
r2_sph = summary(lm_sph)$r.squared # extrai R2
```


# opções de gráficos mais completos
#1
```{r}
corrplot::corrplot(cor(dados), method = "color", addCoef.col="grey")
```

#2
```{r}
PerformanceAnalytics::chart.Correlation(dados, method="pearson", histogram=TRUE)
```

#3
```{r}
GGally::ggpairs(dados)
```

