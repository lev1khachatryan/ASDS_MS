rm(list = ls())
R.version.string # "R version 3.5.1 (2018-07-02)"


## Problem 1

# I wrote this problem using python , it is contained in main.py file. 
# If it is possible, can you check this part in python.


## Problem 5 , coding part

pbinom(5150, size = 10000, prob = 0.5) - pbinom(4950, size = 10000, prob = 0.5)

## Problem 6

# a
pnorm(3.5, mean = 0, sd = 1) - pnorm(2, mean = 0, sd = 1)
# b
pnorm(-80/sqrt(700/3), mean = 0, sd = 1) - pnorm(-60/sqrt(700/3), mean = 0, sd = 1)

## Problem 7
ppois(q = 190, lambda = 200)

## Problem 8

n <- 1
while (TRUE) {
  if (pnorm((-0.5 * sqrt(12*n)/sqrt(35)), mean = 0, sd = 1) - pnorm((-0.5 * sqrt(12*n)/sqrt(35)), mean = 0, sd = 1) >= 0.99) {
    break
  } else{
    n <- n+1
  }
}
print(n)

## Problem 9
1 - pnorm(2/sqrt(3))
