
# Resolver a traves de eliminaciones elementales, la siguiente matriz:

# a <- c(1,2,-2,0,1,2,4,-1,0,-4,-3,-6,12,2,-12,1,2,-2,-4,-5)
a <- c(1,2,-2,0,1,2,4,-1,0,-4,-3,-6,12,2,-12,1)

# A <- matrix(a, 4, 5, byrow=T)
A <- matrix(a, 4, 4, byrow=T)
A
eigen(A)
chol(A) # debe ser una matriz cuadrada, simétrica, definida positiva.

# Fila 2:
p = -A[2,1]/A[1,1]
A[2,] <- A[2,] + p*A[1,]
A

# Fila 3:
p = -A[3,1]/A[1,1]
A[3,] <- A[3,] + p*A[1,]
A

# Fila 4:
p = -A[4,1]/A[1,1]
A[4,] <- A[4,] + p*A[1,]
A

# Ahora A[2,3] es el pivote, Fila 3:
p = -A[3,3]/A[2,3]
A[3,] <- A[3,] + p*A[2,]
A

# Ahora, el pivote es A[3,4], Fila 4:
p = -A[4,4]/A[3,4]
A[4,] <- A[4,] + p*A[3,]
A

 
