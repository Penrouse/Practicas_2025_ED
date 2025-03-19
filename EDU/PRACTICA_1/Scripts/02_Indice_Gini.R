# Librerias
library(dplyr)
library(data.table)
library(readxl) 
library(scales)
library(DescTools)
library(sf)

boyaca <- fread("Data/CNA2014_ENCABEZADO_15.csv") %>% 
  select(P_S7P85B,TIPO_UC,P_MUNIC) %>% 
  filter(TIPO_UC == "1") %>% 
  mutate(P_MUNIC = as.character(P_MUNIC)) %>% 
  na.omit()
str(boyaca)
table(boyaca$TIPO_UC)

tabla1 <- read_excel("Data/Diccionario final.xlsx", sheet = "Hoja2") %>% 
  select(-DEPARTAMENTO)
str(tabla1)

# Union de tabla1
df_boyaca <- boyaca %>% 
  left_join(tabla1, by = c("P_MUNIC"="P_MUNIC")) %>% 
  data.frame() %>% 
  filter(!is.na(P_S7P85B)) %>% 
  mutate(ingreso = 800*P_S7P85B)
str(df_boyaca)


# Calculo indice de gini
# ?Gini

municipios <- names(table(df_boyaca$Nombre.del.municipio))

municipio_i <- c()
indice <- c()
for (i in 1:length(municipios)) {
  aux <- df_boyaca %>%
    filter(Nombre.del.municipio == municipios[i]) %>%
    select(ingreso) %>%
    as.matrix() %>%
    as.vector()
  indice[i] <- round(Gini(aux), 3)
  municipio_i[i] <- municipios[i]
}
salida <- data.frame(indice,municipio_i)

# agregado
agregado <- df_boyaca %>% 
  group_by(P_MUNIC,Nombre.del.municipio) %>% 
  summarise(total_leche = sum(P_S7P85B, na.rm = T),
            total_ingreso = sum(ingreso, na.rm = T),
            indice_gini = Gini(ingreso)) %>% 
  ungroup() %>% 
  mutate(P_MUNIC = substr(P_MUNIC,start = 3, stop = 5)) %>%
  left_join(salida,  by = c("Nombre.del.municipio" = "municipio_i"))
str(agregado)


# Instalar y cargar el paquete sf

# Leer el archivo shapefile con sf
capa_municipios <- st_read("Data/MGN2016_00_NACIONAL/MGN_ADM_MPIO_POLITICO.shp", 
                           options = "ENCODING=UTF-8")

# Ver la clase del objeto
class(capa_municipios)

# Filtrar municipios de un departamento específico (por ejemplo, código 15 para Boyacá)
poligonos_mpios_boy <- capa_municipios %>% filter(DPTO_CCDGO == "15") # Ajustar para su departamento


poligonos_mpios_boy <- poligonos_mpios_boy %>% 
  mutate_if(is.factor, as.character) %>% 
  left_join(agregado, by = c("MPIO_CCDGO"="P_MUNIC"))
class(poligonos_mpios_boy)


# Verificar el CRS actual de la capa
st_crs(poligonos_mpios_boy)

# Transformar al sistema de coordenadas WGS84 (EPSG:4326)
poligonos_mpios_boy <- st_transform(poligonos_mpios_boy, crs = 4326)


### MAPA
library(leaflet)

pal_fun = colorBin(palette="viridis", domain=poligonos_mpios_boy$total_leche, na.color="transparent")
p_popup <- paste0("MUNICIPIO: ", poligonos_mpios_boy$MPIO_CNMBR, "; ","PRODUCCIÓN: ", comma(poligonos_mpios_boy$total_leche))
map <- leaflet(options = leafletOptions(zoomControl = FALSE, attributionControl=FALSE, minZoom = 8, maxZoom = 16))
map <- map %>%
  addProviderTiles(provider = "CartoDB.Positron",
                   options = providerTileOptions(opacity = 1)) %>%
  addPolygons(data=poligonos_mpios_boy, stroke = TRUE, fillColor = ~pal_fun(total_leche), fillOpacity = 0.8, smoothFactor = 0.5,
              popup = p_popup, color = "blue", weight = 1) %>% 
  addLegend("bottomleft", pal=pal_fun, values=poligonos_mpios_boy$total_leche, title = 'Total Leche')
map
saveRDS(map, "Resultados/map.rds")


pal_fun = colorBin(palette="viridis", domain=poligonos_mpios_boy$indice_gini, na.color="transparent")
p_popup <- paste0("MUNICIPIO: ", poligonos_mpios_boy$MPIO_CNMBR, "; ","INDICE: ", poligonos_mpios_boy$indice)
map2 <- leaflet(options = leafletOptions(zoomControl = FALSE, attributionControl=FALSE, minZoom = 8, maxZoom = 16))
map2 <- map2 %>%
  addProviderTiles(provider = "CartoDB.Positron",
                   options = providerTileOptions(opacity = 1)) %>%
  addPolygons(data=poligonos_mpios_boy, stroke = TRUE, fillColor = ~pal_fun(indice), fillOpacity = 0.8, smoothFactor = 0.5,
              popup = p_popup, color = "blue", weight = 1) %>% 
  addLegend("bottomleft", pal=pal_fun, values=poligonos_mpios_boy$indice, title = 'Indice Gini')
map2
saveRDS(map2, "Resultados/map2.rds")
