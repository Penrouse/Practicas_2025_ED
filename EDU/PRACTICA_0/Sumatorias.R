# Sumatorias 

# Dado el vector x, encuentre la suma de los inversos multiplicativos
x <- c(1,2,3,4,5)
sum(x)
sum(1/x)
length(x)
# Suma mediante ciclo for:

serie <- function(x)
{
n <- length(x)
z <- c()
for(i in 1:n)
	{
	z[i] <- (1/i)
	}
print(sum(z))
return(z)
}

serie(x)

1/((log10(10)/log10(2))*(log10(10)/log10(5)))


