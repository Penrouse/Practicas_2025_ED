library(writexl)

# Crear un dataframe con los estudiantes
estudiantes <- data.frame(Nombre = c(
  "JENNY PAOLA",
  "ANDRES JULIAN",
  "BRIAN EDUARD",
  "WILSON ANDRÉS",
  "PEDRO ESTIVEN",
  "KAREN MARIANA",
  "WILLIAM DAVID",
  "SANTIAGO",
  "YESICA YULIETH",
  "SEBASTIAN GABRIEL",
  "JOHN ALEXANDER",
  "LAURA DANIELA"
  )
)

# Asignar números aleatorios del 1 al 32 sin el 15
set.seed(123)  # Esto asegura reproducibilidad, puedes cambiar el valor o quitarlo si lo prefieres
estudiantes$Numero = sample(c(
  05,  08,  11,  13,  17,  18,  19,
  20,  23,  25,  27,  41,  44,  47,  50,
  52,  54,  63,  66,  68,  70,  73,  76,
  81,  85,  86,  91,  94,  95,  97,
  99
), size = nrow(estudiantes))

# Mostrar el dataframe resultante
print(estudiantes)

write_xlsx(estudiantes, "Listado sorteo de departamentos.xlsx")

# # Variables de tipo cuali para el análisis:
# PRED_ETNICA, # TR 6
# S05_TENENCIA, # TR 7
# P_S6P71 # TR 8
# P_S6P65 # Pastos o sabanas
# 
# # Variables de tipo cuanti para el análisis:
# P_S6P66, # Area de pastos
# P_S7P84F, # Hembras
# P_S7P85B, # Leche
# P_S12P150A, # Area total
# P_S15P158B # Personas en el predio
