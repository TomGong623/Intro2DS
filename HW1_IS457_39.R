# Personal Course Number: 39

# Do not remove any of the comments. These are marked by #

# HW 1 - Due Monday Sep 17, 2018 in moodle at 1pmCT and hardcopy in class.

# (1). Please upload R code and report to Moodle 
#      with filename: HW1_IS457_YourClassID.
# (2). Turn in a hard copy of your report in class 
#      without your name but only your class ID, 
#      violators will be subject to a points deduction.

## Important: Make sure there is no identifying information on your printout, including name, username etc. 
## Only include your class ID on there. 

# Part 1. LifeCycleSavings Data

# In this part, we will work with a built-in dataset -- LifeCycleSavings.
# (1) R has a built-in help funtion, write your call to the help function below, as well as something
# that you learned about this dataset from the help function. (1 pt)

# Your code/answer here
help("LifeCycleSavings")
# The dataset "LifeCycleSavings is a built-in dataset" about data on the savings ratio between 1960-1970,
# obtained from Belsley, Kuh and Welsh (1980).

# (2) Describe this dataset (structure, variables, value types, size, etc.) (2 pts)

# Your code/answer here
help("LifeCycleSavings")
summary(LifeCycleSavings)
# This dataset is structured as a data frame with 50 observations (size) on 5 variables:
# sr (numeric)
# pop15 (numeric)
# pop75 (numeric)
# dpi (numeric)
# ddpi (numeric)

# (3) What is "aggregate personal savings" in this dataset? Calculate the average aggregate 
# personal savings of these 50 countries. (1 pt)

# Your code/answer here
# "agregate personal savings" represents the gross of personal savings of each country.
df1 <- LifeCycleSavings
aps <- LifeCycleSavings$sr
aaps <- sum(aps)/50
print(aaps)
# As what is calculated, the average aggregate personal savings of all 50 countries is 9.671.

# (4) What is "dpi" in this dataset? Find the highest and lowest dpi. (2 pts)

# Your code/answer here
# "dpi" is the real per-capita disposable income of each country.
summary(df1$dpi)
# The highest dpi is 4001.89 while the lowest is 88.94.

# (5) How many countries have a dpi above median? (2 pts)
# hint: you might need to find a function to count rows.

# Your code/answer here
dpi_med <- median(df1$dpi)
dpi_am <- subset(df1, df1$dpi > dpi_med)
nrow(dpi_am)
# There are 25 countries having a dpi above median.

# (6) What is the highest aggregate personal savings of the countries 
# whose pop15s are more than 10 times their pop75s? (2 pts)

# Your code/answer here
df1_pop <- subset(df1, df1$pop15 > 10*df1$pop75)
summary(df1_pop$sr)
# The highest aggregate personal savings of the countries whose pop15s are more than 10 times
# their pop75s is 21.100

# (7) For the countries with dpi above the 75th percentile, what is their average aggregate personal savings? 
# For the countries with dpi above the 75th percentale, what is their median aggregate personal savings?
# Why are these two statistics different?

# Your code/answer here
summary(df1$dpi)
df1_dpi_75 <- subset(df1, df1$dpi > 1795.62)
nrow(df1_dpi_75)
print(sum(df1_dpi_75$sr)/nrow(df1_dpi_75))
summary(df1_dpi_75$sr)
# For the countries with dpi above the 75th percentile, their average aggregate personal savings
# is 10.28 while the median is 10.35.
# The reason why these two statistics are different is that in this subset the countries with
# relatively higher aggregate personal savings are more than the countries with relatively lower
# personal savings, but the minority of the countries have relatively low aggregate personal savings.


# (8) Let's look at countries with dpi below the 25th percentile. What is their average and their median
# aggregate personal savings? 
# Why are these two statistics different? Is the pattern of difference different than what you saw in 
# Q7? Why or Why not?

# Your code/answer here
df1_dpi_25 <- subset(df1, df1$dpi < 288.21)
summary(df1_dpi_25$sr)
# For the countries with dpi below the 25th percentile, their average aggregate personal savings
# is 7.544 while the median is 5.750.
# The reason why these two statistics are different is that in this subset the countries with
# relatively lower aggregate personal savings are more than the countries with relatively higher
# personal savings, but the minority of the countries have fairly high aggregate personal savings.

# (9). (3 pts)
# Try running each expression in R.
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with 
# the problem you find in the expression.

LifeCycleSavings[LifeCycleSavings$pop15 > 10]
a = LifeCycleSavings
### Error message here
# Error in `[.data.frame`(LifeCycleSavings, LifeCycleSavings$pop15 > 10) : 
#   undefined columns selected
### Explanation here
# The class of the dataset is a data frame, which means both row and column attributes are involved.
# In order to show the elements by rows, the column objects are supposed to be selected.
# The corrected code should be "LifeCycleSavings[LifeCycleSavings$pop15 > 10,]"

mean(pop15,pop75)
### Error message here
# Error in mean(pop15, pop75) : object 'pop15' not found
### Explanation here
# pop15 and pop75 are columns in the data frame, which are not able to be invoked if the 
# data frame is not specified.

mean(LifeCycleSavings$pop15, LifeCycleSavings$pop75)
### Error message here
# Error in mean.default(LifeCycleSavings$pop15, LifeCycleSavings$pop75) : 
#   'trim' must be numeric of length one
### Explanation here
# The function mean is not able to run on more than one objects at the same time. If it 
# is expected to apply the function on multiple columns at once, the function "sapply" is 
# supposed to be used.

# Part 2. Plot analysis

# Run the following code to make a plot.
# (don't worry right now about what this code is doing)
plot(LifeCycleSavings$pop15, LifeCycleSavings$pop75, xlab = 'pop15', ylab = 'pop75', main = 'pop15 vs pop75')

# (1) Use the Zoom button in the Plots window to enlarge the plot. 
# Resize the plot so that it is long and short, making it easier to read.
# Include an image of this plot in the homework you turn in. (1 pt)

# Your answer here


# (2) Make an interesting observation about the relationship between
#     pop15 and pop75 based on your plot. 
# (something that you couldn't see with the calculations so far.) (1 pt)

# Your answer here
# There is a phenemonon discovered from the plot is the relationship between pop15 and 
# pop75 is approximately with linear-negative correlation, which means those countries with
# higher young people proportion are of lower old people proportion while those countries with
# higher old people proportion are of lower young people proportion.

# (3) Based on our analysis so far, what interesting question about the LifeCycleSavings data
# would you like to answer, but don't yet know how to do it? (1 pt)

# Your answer here
# The question I am interested in is how the age difference would impact the savings ratio
# based on this dataset.


# Part 3. Random number generators
# For the remainder of this assignment we will work with 
# one of the random number generators in R.

# (1) Use you UIN number to set the seed in the set.seed() function. (1 pt)

# Your code here
set.seed(668712660)


# (2) Generate a vector called "normsample" containing 1000 random samples from a 
# normal distribution with mean 2 and standard deviation 1. (1 pt)

# Your code here
normsample <- rnorm(1000, 2, 1)

# (3) Calculate the mean and standard deviation of the normsample. (2 pts)

# Your code here
normsample_mean <- mean(normsample)
print(normsample_mean)
# The mean is 2.020489.
normsample_sd <- sd(normsample)
print(normsample_sd)
# The standard deviation is 1.011511

# (4) Use logical operations (>,<,==,....) to calculate
# the fraction of the values in "normsample" that are more than 3. (1 pt)

# Your code here
k <- 0
for (i in 1:1000){
  if (normsample[i] > 3){
    k <- k + 1
  }
}
print(k)
print(k/length(normsample))
# The fraction of the values in "normsample" that are more than 3 is 0.162.

# (8). Find the area under the normal(2, 1) curve to the right of 3.  
# This should be the probability of getting a random value more than 3. 
# (Hint: Look up the help for rnorm. You will see a few other functions listed.  
#  Use one of them to figure out about what answer you should expect.)
# What value do you expect? 
# What value did you get? 
# Why might they be different? (3 pts)

# Your code here
# The value I expected is 0.162
help("rnorm")
pnorm(3, mean = 2, sd = 1, lower.tail = FALSE)
# The value I got is 0.1586553
# By using the function of "pnorm", the assumption is the number of samples is infinity
# while the number of samples for calculating the expected value is 1000, which made 
# the difference.


