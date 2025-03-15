
# Librerias ---------------------------------------------------------------

library(dplyr)
library(data.table)
library(readxl)
library(ggplot2)

options(scipen = 999)

# Carga de datos ----------------------------------------------------------

datos <- fread(input = "Data/CNA2014_ENCABEZADO_15.csv",
               sep = ",") %>% 
  select(COD_VEREDA,TIPO_UC,S05_TENENCIA,P_S5PAUTOS,P_S7P82,P_S7P84F,P_S7P85B) %>% 
  filter(TIPO_UC == 1) %>% 
  mutate(S05_TENENCIA = as.character(S05_TENENCIA))
str(datos)
glimpse(datos)

# Limpieza ----------------------------------------------------------------

t_homologacion_7 <- readxl::read_excel(
  path = "Data/Tablasdehomologacion.xlsx",
  sheet = "Hoja2") %>% 
  mutate(S05_TENENCIA = as.character(S05_TENENCIA))
str(t_homologacion_7)

datos_dep <- datos %>% 
  left_join(t_homologacion_7, by = c("S05_TENENCIA"="S05_TENENCIA")) %>% 
  select(Predominancia,P_S7P85B) %>% 
  na.omit() 
# %>% 
#   filter(P_S7P85B < 1000)
str(datos_dep)

# datos_dep <- dplyr::left_join(datos, t_homologacion_7, by....)


# TDF Cualitativa ---------------------------------------------------------

tdf_S05_TENENCIA <- datos_dep %>% 
  group_by(Predominancia) %>% 
  summarise(n_i = n()) %>% 
  arrange(desc(n_i)) %>% 
  mutate(N_i = cumsum(n_i),
         f_i = n_i/sum(n_i),
         F_i = cumsum(f_i))

# Grafico
# barplot(table(datos_dep$Predominancia))

# Usando esquisser
# install.packages("esquisse")
# library(esquisse)
# esquisse::esquisser(viewer = "browser")

# Grafico de barras
ggplot(datos_dep) +
  aes(x = Predominancia) +
  geom_bar(fill = "#FF69B4") +
  labs(
    title = "Distribución de Predominancia",
    subtitle = "CNA"
  ) +
  coord_flip() +
  theme_minimal()


# TDF - Variable cuanti ---------------------------------------------------

# Leer paquete DT, datatable

# Numero de clases
k = round(1 + 3.3 * log10(nrow(datos_dep)))
k

# Rango
rango = max(datos_dep$P_S7P85B, na.rm = T) - 
  min(datos_dep$P_S7P85B, na.rm = T)
rango

# Longitud
longitud = rango/k
longitud

# Cortes
cortes <- min(datos_dep$P_S7P85B, na.rm = T) + c(seq(0,k,1))*longitud
cortes

# TDF - Leche

tdf_P_S7P85B <- datos_dep %>% 
  mutate(P_S7P85B_c = as.factor(cut(P_S7P85B,
                          breaks = cortes,
                          levels = cortes,
                          include.lowest = T,
                          dig.lab = 6)
                          )
         ) %>% 
  group_by(P_S7P85B_c, .drop = F, .add = F) %>% 
  summarise(n_i = n()) %>% 
  mutate(N_i = cumsum(n_i),
         f_i = n_i/sum(n_i),
         F_i = cumsum(f_i),
         x_i = cortes[1:k] + longitud/2,
         c_i = abs(cortes[1:k] - cortes [2 : (k+1)]),
         d_i = n_i/c_i)
# :) :)


# Histograma 
hist(datos_dep$P_S7P85B)
mean(datos_dep$P_S7P85B)
median(datos_dep$P_S7P85B)


# Estadisticas descriptivas -----------------------------------------------

# Medidas de tendencia central
media <- mean(datos_dep$P_S7P85B, na.rm = T)
mediana <- median(datos_dep$P_S7P85B, na.rm = T)
# moda: datos discretos o valores agrupados en intervalo

# Medidas de posición
Q1 <- quantile(
  datos_dep$P_S7P85B, 
  na.rm = T, 
  probs = 0.25, 
  type = 6)
Q2 <- quantile(
  datos_dep$P_S7P85B, 
  na.rm = T, 
  probs = 0.50, 
  type = 6)
Q3 <- quantile(
  datos_dep$P_S7P85B, 
  na.rm = T, 
  probs = 0.75, 
  type = 6)

Deciles <- quantile(
  datos_dep$P_S7P85B, 
  na.rm = T, 
  probs = seq(0,1,0.1), 
  type = 6)
Deciles

Percentiles <- quantile(
  datos_dep$P_S7P85B, 
  na.rm = T, 
  probs = seq(0,1,0.01), 
  type = 6)
Percentiles

# Medidas de variabilidad 
riq <- Q3 - Q1
des_abs <- mean(abs(datos_dep$P_S7P85B - media))
varianza <- mean((datos_dep$P_S7P85B - media)^2)
# var(datos_dep$P_S7P85B): Esta no se usa porque tenemos una población
desv_std <- sqrt(varianza)
recorrido_rel <- rango/media
recorrido_semi_inter <- (Q3-Q1)/(Q3+Q1)
CV <- 100*desv_std/abs(media) # Si es mayor del 30%, alta variabilidad

# Tabla de resumen
tb_resumen <- data.frame(
  Minimo = min(datos_dep$P_S7P85B, na.rm = T),
  Q1 = Q1,
  Media = media,
  Mediana = mediana,
  Q2 = Q2,
  Q3 = Q3,
  Maximo = max(datos_dep$P_S7P85B, na.rm = T)
)

# Tabla resumen de medidas de vriabilidad



