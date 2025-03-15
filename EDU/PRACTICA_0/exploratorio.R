z <- rnorm(100)
z

x <- rnorm(1000000, mean = 3, sd = 1)
x

# Momento de orden cero con respecto a promedio: mu_0 = 1
sum(
  (x - mean(x))^0
  )/
  length(x)

# mu_1 = 0
x - mean(x)
(x - mean(x))^1
sum((x - mean(x))^1)

# Datos iris
data(iris)
hist(iris$Sepal.Length)
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
