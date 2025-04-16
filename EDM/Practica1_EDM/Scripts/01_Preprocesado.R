
# Importar librerias ------------------------------------------------------

library(data.table)
library(dplyr)
library(readxl)
library(stringr)


# Tablas de homologacion --------------------------------------------------

tr_6 <- read_excel("Data/input/TEMATICA_DISENO DE REGISTRO CNA2014.xlsx", 
                   sheet = "TABLAS_REFERENCIA",
                   range = "R2:S10") %>% 
  rename("PRED_ETNICA_c"="Pedominancia étnica")

tr_7 <- read_excel("Data/input/TEMATICA_DISENO DE REGISTRO CNA2014.xlsx", 
                   sheet = "TABLAS_REFERENCIA",
                   range = "U2:V13") %>% 
  rename("S05_TENENCIA_c" = "Predominancia de tenencia en la Unidad productora")

tr_8 <- read_excel("Data/input/TEMATICA_DISENO DE REGISTRO CNA2014.xlsx", 
                   sheet = "TABLAS_REFERENCIA",
                   range = "X2:Y15") %>% 
  rename("P_S6P71_c" = "principal fenomeno que afectó los pastos sembrados")


# Construcción de dataframe -----------------------------------------------

datos <- fread("Data/input/S01_15_Unidad_productora_.csv") %>% 
  filter(TIPO_UC == 1) %>% 
  select(TIPO_REG,
         ENCUESTA,
         COD_VEREDA,
         # Variables cualitativas
         PRED_ETNICA, # TR 6
         S05_TENENCIA, # TR 7
         P_S6P71, # TR 8
         P_S6P65, # Pastos o sabanas,
         # Variables cuantitativas
         P_S6P66, # Area de pastos
         P_S7P84F, # N. de hembras
         P_S7P85B, # Leche
         P_S12P150A, # Area total
         P_S15P158B # Personas en el predio
         ) %>% 
  na.omit() %>% 
  mutate_at(.vars = c("TIPO_REG","ENCUESTA","COD_VEREDA","PRED_ETNICA","S05_TENENCIA","P_S6P71","P_S6P65"), 
            .funs = as.character) %>% 
  left_join(tr_6, by = "PRED_ETNICA") %>% 
  left_join(tr_7, by = "S05_TENENCIA") %>% 
  left_join(tr_8, by = "P_S6P71") %>% 
  mutate(P_S6P65_c = ifelse(P_S6P65 == "1", "Si", "No")) 

str(datos)

# Como supera el 5% de valores faltantes, no tiene sentido imputar
sum(is.na(datos$P_S7P84F))
sum(is.na(datos$P_S7P85B))



# Exportamos --------------------------------------------------------------

saveRDS(datos, "Data/output/datos_dep.rds")
write.csv(datos, "Data/output/datos_dep.csv")

