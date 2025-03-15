# Valores y vectores Propios

# Ejemplo 1 

A <- matrix(c(4,-6,6,3,-5,8,2,-4,7),nrow = 3,byrow = T)

B <- matrix(c(4,5,3,-4,13,3,-4,5,11),nrow = 3,byrow = T)

C <- matrix(c(0,3,4,4,-4,-8,-4,8,12),nrow = 3,byrow = T)

eigen(A)

eigen(A)$values

eigen(A)$vectors

A%*%eigen(A)$vectors[,1]
eigen(A)$values[1]*eigen(A)$vectors[,1]

A%*%eigen(A)$vectors[,2]
eigen(A)$values[2]*eigen(A)$vectors[,2]

A%*%eigen(A)$vectors[,3]
eigen(A)$values[3]*eigen(A)$vectors[,3]

# Ejemplo 2
matriz <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)

# Mostrar la matriz
print(matriz)

# Obtener el rango de la matriz
rango_matriz <- rank(matriz)

# Mostrar el rango
print(rango_matriz)


# ------------------------------------------------------------------------------------------------
# Ejemplo 2

x <- c(1,-1,4,3,2,-1,2,1,-1)

A <- matrix(x,ncol = 3,byrow = T)
A

eigen(A)









