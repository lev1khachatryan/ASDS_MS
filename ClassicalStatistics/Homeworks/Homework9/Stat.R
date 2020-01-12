
rm(list = ls())

# R.version.string  ## "R version 3.5.1 (2018-07-02)"
## 3
qchisq(.95, df=2)

## 6 - d
vec <- c(1.88, -0.16, 1.95, 0.30, -0.41, 1.49, -0.30, -0.74, 2.34, 0.28)
n <- length(vec)
s <- sqrt(sum((vec-mean(vec))^2)/(n-1))
t <- (mean(vec) - 1.2)/(s/sqrt(n))
c <- qt(.975 , df = n-1)
abs(t) > c

## 7
vec7 <- c(66, 79, 80, 74, 81, 79, 65, 78, 77, 69)
n <- length(vec7)
s <- sqrt(sum((vec-mean(vec))^2)/(n-1))
t <- (mean(vec) - 70)/(s/sqrt(n))
c <- qt(.99 , df = n-1)
abs(t) > c

## 4
X <- round(x = rnorm(n = 50, mean = 0.6 , sd = 2), digits = 2)
t.test(x = X , mu = 0.5, conf.level = 0.95)


## 5
setwd("C:\\Users\\User\\Desktop\\StatHW9")
dat <- read.csv("AAPL.csv", stringsAsFactors = FALSE)
# View(dat)

