# DESCOMPOSICI?N ESPECTRAL


# Matriz simétrica
S<-matrix(c(2,1,1,1,2,1,1,1,3),3,3)
S
t(S)

# Evaluar la descomposion espectral de S
eigen(S)$vectors%*%diag(eigen(S)$values)%*%t(eigen(S)$vectors)

svd(S)
