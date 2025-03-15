# SIMULACIÓN

# Calculo de áreas por medio de simulación

n = 1000
u = runif(n,0,1)
v = runif(n,0,1)
x = runif(n,-3,0)
# Ahora dibujamos los puntos
plot(u,v,xlim=c(0,1.5),ylim=c(0,1.5),ylab="",pch=".")
curve(x^2,col="red",type="l",lwd=3,add=T)
# Luego contamos el número de puntos que caen bajo la gráfica :
z <- (v <= u^2 & v >=0) # Un vector lógico
sum(z) # Recordemos que TRUE=1 y FALSE=0

# Área
sum(z)/n


# Cálculo de integrales por medio de Métodos Numéricos
fx <- function(x) x^2
integrate(fx,0,1)


# Calculo de volumenes

# http://cran.r-project.org/web/packages/cubature/index.html
# Cargar .zip local
# "cubature 1.0.zip"

library(cubature) # load the package "cubature"
f <- function(x) { 2/3 * (x[1] + x[2] + x[3])} # "x" is vector
adaptIntegrate(f, lowerLimit = c(0, 0, 0), upperLimit = c(1, 1, 1))


# Calculo de derivadas
D(expression(x^2), "x")


# Sistema de ecu
A <- matrix(c(6,4,2,
              -1,3,-1,
              1,-2,-1),ncol = 3, byrow = T)
A
det(A)
eigen(A)

b <- c(23,2,-6)
solve(A)%*%b
