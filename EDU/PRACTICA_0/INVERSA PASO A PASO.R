# INVERSA DE UNA MATRIZ PASO A PASO

A <- matrix(c(2, 2, 3, 3, 5, 9, 5, 6, 7), ncol = 3)
A

# Agregamos la matriz identidad
AB <- cbind(A, diag(c(1, 1, 1)))
AB

# Primer paso
AB[1, ] <- AB[1, ]/AB[1, 1] ; AB
AB[2, ] <- AB[2, ] - 2 * AB[1, ] ; AB
AB[3, ] <- AB[3, ] - 3 * AB[1, ] ; AB
AB

# Paso 2
AB[2, ] <- AB[2, ]/AB[2, 2] ; AB
AB[3, ] <- AB[3, ] - 4.5 * AB[2, ] ; AB

# Paso 3
AB[3, ] <- AB[3, ]/AB[3, 3]
AB

# Paso 4
AB[2, ] <- AB[2, ] - 0.5 * AB[3, ] ; AB
AB[1, ] <- AB[1, ] - 2.5 * AB[3, ] ; AB
AB

# Paso 5
AB[1, ] <- AB[1, ] - 1.5 * AB[2, ]
AB

# Matriz Inversa
B <- AB[, 4:6]
A %*% B




