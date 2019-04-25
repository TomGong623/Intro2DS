# Do not remove any of the comments. These are marked by #
# HW 2 - Due Monday, Sep 24 2018 in moodle and for non-online students hardcopy in class.
# (1). Please upload R code and report to Moodle with filename: HW2_IS457_YourCourseID.
# (2). Turn in hard copy of your report in class.

### Class ID: 39

# In this assignment you will practice manipulating vectors and dataframes.
# You will take subsets, create new data structures, and end with creating a fantastic plot.
# You will work with the CO2 dataset in the R library and a dataset called SFHousing. 
# Before beginning with the datasets however, you will do some warm up exercises.



# PART 1. Warm up (4 pts)
# Q1. Create a Vector like this (0 0 0 3 3 3 6 6 6 9 9 9 12 12 12 15 15 15 18 18 18) 
#     with functions seq() and rep() and call it "vec" (1 pt)

### Your code below
x = seq(0, 18, by = 3)
print(x)
vec = rep(x, each = 3)
print(vec)
# Q2. Calculate the fraction of elements in vec that are more than or equal to 9. (2 pts)
# hint: R can do vectorized operations. 

### Your code below
length(vec[vec >= 9])/length(vec)
# As calculated, the faction of elements in vec that are more than or equal to 9 is 57.14%.

# Q3. Create a Vector like this (1 2 2 3 3 3 4 4 4 4 5 5 5 5 5)
#     with functions rep() and the : operator (1 pt)

### Your code below
y = c(1:5)
print(y)
vec_1 = rep(y, y)
print(vec_1)

# PART II. CO2 Data (9 pts)
# Q4. Use R to generate descriptions of the CO2 data which is already available with the base R installation (it
# is called CO2 in R. Please note that we are using the CO2 dataset and not the similarly named co2 dataset). 
# Print out the summary of each column and the dimensions of the dataset. (2 pts.)
# (hint: you may find the summary() and dim() useful). 
# Write up your descriptive findings and observations of the R output. (1 pt.)

### Your code below:
summary(CO2)
dim(CO2)
class(CO2$Plant)
summary(CO2$Plant)
class(CO2$Type)
summary(CO2$Type)
class(CO2$Treatment)
summary(CO2$Treatment)
class(CO2$conc)
summary(CO2$conc)
class(CO2$uptake)
summary(CO2$uptake)

### Your answer below:
# The dimensions of the CO2 dataset are 84 rows and 5 columns.
# The data type of column Plant is ordered factor, totally 12 classes.
# The data type of column Type is factor, with 2 classes "Quebec" and "Mississippi".
# The data type of column Treatment is factor, with 2 classes "nonchilled" and "chilled".
# The data type of column conc is numeric.
# The data type of column uptake is numeric.

# Q5. Show last 8 plants' uptake values (1 pt.)

### Your code below:
help("tail")
tail(CO2$uptake, n = 8)


# Q6. Show all plants' uptake values except the first 20 plants'. (1 pt.)

### Your code below:
CO2[-(1:20),]
CO2$uptake[-(1:20)]



# Q7. Calculate the mean of uptake subseted by the "Treatment" variable.(1 pt)
# hint: apply function family.

### Your code below:
mean(CO2$uptake[CO2$Treatment == "nonchilled"])
# The mean of uptake where "Treatment" is "nonchilled" is 30.64.
mean(CO2$uptake[CO2$Treatment == "chilled"])
# The mean of uptake where "Treatment" is "chilled" is 23.78.

# Q8. Create a logical vector uptake_treatment . (2 pts)

# For the plants with Chilled treatment (Treatment == "chilled"), return value TRUE when uptake > 30.
# For the plants with Non-Chilled treatment (Treatment == "nonchilled"), return value TRUE when uptake > 40.

### Your code below:
uptake_treatment = rep(TRUE, 84)
ind = length(CO2$uptake)
print(ind)
for (i in 1:ind){
  if (CO2$Treatment[i] == "chilled"){
    if (CO2$uptake[i] > 30){
      uptake_treatment[i] = TRUE
    }
    else{
      uptake_treatment[i] = FALSE
    }
  }
  else if (CO2$Treatment[i] == "nonchilled"){
    if (CO2$uptake[i] > 40){
      uptake_treatment[i] = TRUE
    }
    else{
      uptake_treatment[i] = FALSE
    }
  }
}
print(uptake_treatment)

# Q9. Here is an alternative way to create the same vector in Q8.
# First, we create a numeric vector uptake_test that is 30 for each plant with chilled treatment
# and 40 for each plant with non chilled treatement. To do this, first create a vector of length 2 called 
# test_val whose first element is 40 and second element is 30. (1 pt)

### Your code below:
test_val = c(40, 30)



# Create the uptake_test vector by subsetting test_val by position, where the 
# positions could be represented based on the Treatment column in CO2. (1 pt)

### Your code below
uptake_test = ifelse(CO2$Treatment =="chilled", test_val[2], test_val[1])


# Finally, use uptake_test and the uptake column to create the desired vector, and
# call it uptake_treatment2. (1 pt)

### Your code below

uptake_treatment2 = ifelse(CO2$uptake>uptake_test, TRUE, FALSE)
print(uptake_treatment2)


#PART 3.  San Francisco Housing Data (25 pts.)
#
# Load the data into R.
load(url("https://www.stanford.edu/~vcs/StatData/SFHousing.rda"))

# Q10. (3 pts.)
# What objects are in SFHousing.rda? Give the name and class of each.

### Your code below
class(cities)
objects(cities)
class(housing)
objects(housing)

### Your answer here
# There are two objects in SFHousing.rda, "cities" and "housing". Both of the two objects
# are data frame.


# Q11. give a summary of each object, including a summary of each variable and the dimension of the object. (4 pts)

### Your code below
objects(cities)
summary(cities)
dim(cities)
class(cities$longitude)
class(cities$latitude)
class(cities$county)
class(cities$medianPrice)
class(cities$medianSize)
class(cities$numHouses)
class(cities$medianBR)
objects(housing)
summary(housing)
dim(housing)
class(housing$county)
class(housing$city)
class(housing$zip)
class(housing$street)
class(housing$price)
class(housing$br)
class(housing$lsqft)
class(housing$bsqft)
class(housing$year)
class(housing$date)
class(housing$long)
class(housing$lat)
class(housing$quality)
class(housing$match)
# The object "cities" is consisted of 163 rows and 7 columns.
# There are 7 variables in the object of cities, which are listed as "longitude" (array), 
# "latitude" (array), "county" (factor), "medianPrice" (array), "medianSize" (array),
# "numHouse" (array), "medianBR" (array)
# The object "housing" is consisted of 281506 rows and 15 columns.
# There are 15 varibles in the object of housing, which are listed as "county" (factor), "city" (factor),
# "zip" (factor), "street" (character), "price" (numeric), "br" (integer), "lsqft" (numeric),
# "bsqft" (integer), "year" (integer), "date" (POSIXt), "long" (numeric), "lat" (numeric),
# "quality" (factor), "match" (factor).


# Q12. After exploring the data (maybe using the summary() function), describe in words the connection
# between the two objects (e.g., what links them together). (2 pts)

### Write your response here
# The variable "county" is the common factor shared by two objects while linking them.


# Q13. Describe in words two problems that you see with the data. (2 pts)

### Write your response here
# (1) In object "housing", the variable "long" contains 23315 NA values.
# (2) In object "housing", the variable "quality" has some outliers. 


# Q14. (2 pts.)
# We will work with the houses in San Francisco, Fremont, Vallejo, Concord and Livermore only.

# Subset the housing data frame so that we have only houses in these cities
# and keep only the variables county, city, zip, price, br, bsqft, and year.

# Call this new data frame SelectArea. This data frame should have 36686 observations
# and 7 variables. (Note you may need to reformat any factor variables so that they
# do not contain incorrect levels)

### Your code below
SelectArea = housing[housing$city %in% c("San Francisco", "Fremont", "Vallejo",
                                         "Concord", "Livermore"), c(1,2,3,5,6,8,9)]
dim(SelectArea)
summary(SelectArea)

# Q15. (3 pts.)
# We are interested in making plots of price and size of house, but before we do this
# we will further subset the housing dataframe to remove the unusually large values.

# Use the quantile function to determine the 95th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 95th percentiles
# Call this new data frame SelectArea (replacing the old one) as well. It should 
# have 33693 observations.

### Your code below
quantile(SelectArea$price, 0.95)
quantile(SelectArea$bsqft, 0.95, na.rm = TRUE)
SelectArea = SelectArea[SelectArea$price < 1100000 & SelectArea$bsqft < 2698,]
SelectArea <- SelectArea[!is.na(SelectArea$bsqft), ]
dim(SelectArea)
summary(SelectArea)
# Q16. (2 pts.)
# Create a new vector that is called price_per_sqft by dividing the sale price by the square footage
# Add this new variable to the data frame.

### Your code below
price_per_sqft = SelectArea$price/SelectArea$bsqft
summary(price_per_sqft)
SelectArea = cbind(SelectArea, price_per_sqft)
summary(SelectArea)

# Q17. (2 pts.)
# Create a vector called br_new, that is the number of bedrooms in the house, except
# when the number is greater than 5, set it (br_new) to 5.  

### Your code below
br_new = ifelse(SelectArea$br>5, 5, SelectArea$br)


# Q18. (4 pts. 2 + 2 - see below)
# Use the heat.colors function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25.

# Create a vector called brCols where each element's value corresponds to the color in rCols 
# indexed by the number of bedrooms in the br_new.

# For example, if the element in br_new is 3 then the color will be the third color in rCols.
# (2 pts.)

### Your code below
help("heat.colors")
rCols = heat.colors(5, alpha = 0.25)
brCols = rCols[br_new]



######
# We are now ready to make a plot!
plot(price_per_sqft ~ bsqft, data = SelectArea,
     main = "Housing prices in the San Francisco Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 18, cex = 0.5)
legend(legend = 1:5, fill = rCols, "topright")

# what's your interpretation of the plot? 
# e.g., the trend? the cluster? the comparison? (1 pt.)
# The relationship between price per square foot and size of house is generally in
# negative-correlation, which means the bigger the house is, the lower the price per square
# foot is.


