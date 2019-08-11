library(rgl)
for (i in 1:100){
triangles3d(cbind(rnorm(6), rnorm(6), rnorm(6)), col = "green") # x = numeric vector, y = numeric vector#each triangl is
triangles3d(cbind(rnorm(9), rnorm(9), rnorm(9)), col = "red") # x
triangles3d(cbind(rnorm(9), rnorm(9), rnorm(9)), col = "black") # x = numeric vector, y = numeric vector
triangles3d(cbind(rnorm(9), rnorm(9), rnorm(9)), col = "yellow")
}

