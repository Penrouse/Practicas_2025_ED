# LIMITES Y CONTINUIDAD DE UNA FUNCION

# LIMITES - IDEA INTUITIVA DEL LIMITE DE UNA FUNCION EJERCICIO RESUELTO
# Solucionar lim(x->1)((x^2-1)/(x^3-1))
x<- seq(-4,4,0.05)
fx <- (x^2-1)/(x^3-1) # Al factorizar se tiene
fx2 <- (x+1)/(x^2+x+1)
plot(x,fx,xlim=c(-4,4),ylim=c(-5,5),type="l")
x11()
plot(x,fx2,xlim=c(-4,4),ylim=c(-5,5),type="l")
# Se puede obtener una funcion equivalente sin indeterminacion

# LIMITES - IDEA INTUITIVA DEL LIMITE DE UNA FUNCION PROBLEMA RESUELTO
# Solucionar lim(x->0)(sqrt(4+x)-sqrt(4-x))/x
x<- seq(-4,4,0.1);x
fx <- (sqrt(4+x)-sqrt(4-x))/x;fx # Al multiplicar por el conjugado del numerador
fx2 <- 2/(sqrt(4+x)+sqrt(4-x));fx2
plot(x,fx,xlim=c(-4,4),ylim=c(0.4,0.8),type="l")
x11()
plot(x,fx2,xlim=c(-4,4),ylim=c(0.4,0.8),type="l")

# lim(x->4)(sqrt(x)+3))
x <- seq(0,8,1);x
fx <- sqrt(x)+3;fx
plot(x,fx)

# lim(x->5)((x+3)/(x-3))
x <- seq(0,8,0.1);x
fx <- (x+3)/(x-3);fx
plot(x,fx)

# lim(x->1)(1/((2x-1)(3x-4)))
x <- seq(0,2,0.01);x
fx <- 1/((2*x-1)*(3*x-4));fx
plot(x,fx)



