####################
#####Problem 5######
####################

# a) Using Microsoft Excel, R or any other software, using the Adjusted Close Prices
# ("Adj Close" column), calculate weekly returns of the Dow Jones
R.version.string
rm(list = ls())

db <- read.csv(file="C:/Users/levon.khachatryan/Desktop/Ex5/^DJI.csv",head=TRUE,sep=",")
returns <- vector("list", 53)
i <- 1
for (k in 1 :(length(db["Adj.Close"][,]) - 1)){
  returns[[i]] <- (db["Adj.Close"][k+1,]-db["Adj.Close"][k,])/db["Adj.Close"][k,]
  i <- i + 1
}
returns <- unlist(returns, use.names=FALSE)

# 2) Plot the histogram of weekly returns;
hist(returns)

# 3) Plot the Stem-and-Leaf plot of weekly returns.
stem(returns)


####################
#####Problem 9######
####################
ds <- c(2, 2, 2, 5, 3, 2, 0, 0, 3, 5)

# a) Construct the Empirical CDF for this dataset.
p <- ecdf(ds)
plot(p)

# b) Construct the Density Histogram for this dataset.
hist(ds, freq = F)

# c) Construct the Kernel Density Estimator graph for this dataset on the sameplot, 
# over the Histogram.
hist(ds, freq = FALSE)
dens <- density(ds)
lines(dens)


####################
#####Problem 10#####
####################

#Calculate approximately, as good as you can, the mode, median and mean for this dataset.
ds <-c(floor(runif(46,0, 2)),
       floor(runif(31,2, 4)),
       floor(runif(12,4, 6)),
       floor(runif( 5,6, 8)),
       floor(runif( 2,8, 10)),
       floor(runif( 1,10,13)))
Modes(ds)  ## nkaragrutyuny nerqevuma grvac 
mean(ds)
median(ds)


####################
#####Problem 11#####
####################
ds <- c(4, 3, 1, 0, -2, 3, 2)

# a) Find the range of this dataset;
diff(range(ds)) # 6

# b) Find the sample variance (using n − 1 in the denominator);
var(ds)  # 4.285714

# c) Find the sample standard deviation;
sd(ds)   # 2.070197

# d) Find the Mean Absolute Deviation from the Mean.
mad(ds)  # 1.4826

####################
#####Problem 12#####
####################
# Write an R function to calculate all modes of a given dataset.

Modes <- function(x) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  ux[tab == max(tab)]
}
