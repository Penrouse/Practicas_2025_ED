# Graficos en 3 dimensiones

x = seq(-10,10,length=50)         # Generamos una malla de puntos (x,y)
y = x
f = function(x,y) {x^2 - y^2}   # Definimos la funci?n que dibujaremos
z = outer(x,y,f)                 # La funci?n outer evalua la funci?n f en cada punto(xi,yj)
persp(x,y,z)                    # Un gr?fico en perspectiva
persp(x,y,z,theta=30,phi=30) 


# (2/3)*(X + Y + Z)

x = seq(-10,10,length=50)         # Generamos una malla de puntos (x,y)
y = x
f = function(x,y) { (2/3)*(x + y) / (3/2) }   # Definimos la funci?n que dibujaremos
z = outer(x,y,f)                 # La funci?n outer evalua la funci?n f en cada punto(xi,yj)
persp(x,y,z)                    # Un gr?fico en perspectiva
persp(x,y,z,theta=30,phi=30) 



