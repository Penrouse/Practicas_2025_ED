# Calculo en R
# Cargamos el paquete "mosaic"

library(mosaic)

# Hacer funciones en R
f <- function(x) {2 * x + 3}
f(1)

# Mediante makeFun
f <- makeFun(m * x + b ~ x)

f

# Imagenes
f(x = 2, m = 3.5, b = 10)

# Otra alternativa
f <- makeFun(m * x + b ~ x, m = 3.5, b = 10)
f(x = 2)

# Mas funciones
g <- makeFun(A * x * cos(pi * x * y) ~ x + y, A = 3)
g
g(x = 1, y = 2)

### Graficos
plotFun(A * exp(k * t) * sin(2 * pi * t/P) ~ t, t.lim = range(0, 10), k = -0.3, A = 10,
        P = 4)

plotFun(A * exp(k * t) * sin(2 * pi * t/P) ~ t + k, t.lim = range(0, 10),
        k.lim = range(-0.3,0), A = 10, P = 4)

# Graficos en dos variables
# "surface=TRUE" Para obtener una trama de superficie

# plotFun(A * exp(k * t) * sin(2 * pi * t/P) ~ t + k, 
#         t.lim = c(0, 10), 
#         k.lim = c(-0.3, 0), 
#         A = 10, P = 4, 
#         surface = TRUE)


###### Diferentiation

D(expression(sin(x)), "x")

# Derivada con respecto a x
D(expression(A * x^2 * sin(y)), "x")

# Derivada de una constante
D(expression((A * x + b)) , "y")

library(Deriv)

# Definir la expresión
expr <- expression(A * x^2 * sin(y))

# Obtener la segunda derivada con respecto a x
second_derivative <- deriv(expr, "x", 2)

# Mostrar el resultado
print(second_derivative)

# # Derivadas de segundo orden
# D(D(A * x^2 * sin(y), "x"), "x")
# 
# D(A * x^2 * sin(y) ~ y + y)
# 
# D(A * x^2 * sin(y) ~ x + y) # mixed parcial


# ##### Anti-Diferentiation
# 
# # Calcular \integrate{a*x^2}.dx
# F = antiD(a * x^2 ~ x, a = 1)
# F
# 
# # Calcular \integrate_{1}^{3}{x^2}.dx
# F(x = 3) - F(x = 1)
# 
# # Antiderivada de un logaritmo
# antiD(1/(a * x + b) ~ x)

# Definir la función a integrar
f <- function(x, a) {
  return(a * x^2)
}

# Parámetros
a <- 1

# Calcular la integral definida
result <- integrate(f, lower = 0, upper = 1, a = a)

# Mostrar el resultado
print(result)


#### Solving

# Find the zeros within a specified range
findZeros(sin(t) ~ t, t.lim = range(-5, 1))
plotFun(sin(t) ~ t, t.lim = range(-5, 1))

# Find the nearest several zeros to a point:
findZeros(sin(t) ~ t, nearest = 5, near = 10)

# Especifique un rango a traves de un centro y un ancho:
findZeros(sin(t) ~ t, near = 0, within = 8)

# Para encontrar la solucion de 4*sin(3x) = 2
solve(4 * sin(3 * x) == 2 ~ x, near = 0, within = 1)
4 * sin(3 * 0.1746)
4 * sin(3 * 0.8726)




