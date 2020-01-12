R.version.string
rm(list = ls())
#############
##### 5 #####
#############
recursiveSquareRootBuilder <- function(myVector,n){
  if (n > 4){
    return(1)
  }
  return(sqrt(0.5 + myVector[n]*recursiveSquareRootBuilder(myVector, n+1)))
}

k <- 500 # pordzeri qanakn e
results <- c()
while (k > 0) {
  RVs <- 1000
  RVs <- sample(c(-1,1), replace=TRUE, size=RVs)
  results <- append(results, recursiveSquareRootBuilder(RVs, 1))
  k <- k-1
}
hist(results)

#############
##### 6 #####
#############
i <- 100
NumberOf <- c()
while (i > 0) {
  c <- rnorm(n = 200 , mean = 0.7, sd = 1.1)
  Q1 <- summary(c)[2]
  Q3 <- summary(c)[5]
  IQR <- Q3-Q1
  A <- Q1 - 1.5*IQR
  B <- Q3 + 1.5*IQR
  NumberOf <- append(NumberOf, sum(c < A | c > B))
  i <- i-1
}
mean(NumberOf)

##############
##### 16 #####
##############
data('mtcars')
names(mtcars)
attach(mtcars)

# a)
plot(disp~ wt)

# b)
cor(wt, disp)# Goyutyun uni gcayin kaxvacutyun wt-i u disp-i mijev , vory menq karogh enq nkatel scatterplot-ic

# c)
cov(wt,disp)

# d)
var(disp)

##############
##### 17 #####
##############
# a)
rm(list = ls())
x <- rnorm(n = 200, mean = 3, sd = 5)
y <- runif(n = 300, min = -2, max = 8)
alpha <- seq(0.05,0.95,by = 0.05)
qx <- c()
qy <- c()
for (i in alpha) {
  qx <- append(qx, quantile(x, i))
  qy <- append(qy, quantile(y, i))
}

# b)
qqplot(qx, qy) # goyutyun uni voroshaki korutyun , voric vor menq karogh enq entadrel ,
               # vor dataset-ery galis en tarber distributionneric
# c)
qz <- c()
for (i in alpha) {
  qz <- append(qz, qnorm(p = i,mean = 0, sd = 1))
}

# d)
par(mfrow = c(1, 2))
qqplot(qx,qz)
qqplot(qy,qz)

# arajin graph-um `(qx,qz) , keter@ dasavorvac en grete 1 gci vra , vorteghic 
# karogh enq entadrel vor datasety galis e Normal distributionic . @nd vorum graph-ic karogh enq haskanal , 
# vor distribution@ symmetric e  aranc fat tails-i . 

# Erkrord graph-um `(qy,qz) , ketery aydqan el 1 gci vra chen, bayc shat el chen tarbervum. 
# Goyutyun uni voroshaki korutyun voric karogh enq entadrel , vor dataset@ galis e 
# urish distributionic

