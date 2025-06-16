# code associated with exerpts of the data carpentry lessons
#http://www.datacarpentry.org/R-ecology-lesson/01-intro-to-R.html
#http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html

#Assign a number value to an object
x<-32
class(x) #numeric
typeof(x) #more specific information on how the numeric data is stored (double)

#Assign text value to an object
y<-"hi"
class(y) #character
typeof(y) #character

# Vectors
# Vectors allow you to assign multiple values to an object

age<-c(30,40,25,22) #vector of numbers
animals<-c("cat", "dog", "dog", "dog") #vector of strings (characters)

#What type of values are in the vector?
class(age)
class(animals)

#Class coercion - What types are these vectors?
first_vector<- c(1, 2, 3, "a" )
second_vector <- c(1, 2, 3, "4" )

#calculate the mean of the age vector
mean(age)

#let's get a bunch of summary stats all at once for age
summary(age)

#Can we calculate the mean of the animals vector?
mean(animals)

#let’s convert animals into a factor variable (R's version of a categorical variable)
animals_factor<-factor(animals)

#what are the levels in animals_factor?
levels(animals_factor)

#how many levels are in animals_factor?
nlevels(animals_factor)

#we can also use the summary function on factors
summary(animals_factor)

#if you haven't yet installed the dslabs package, run this code first
install.packages("dslabs")

#use library() to load the package after it it installed
library(dslabs)

#use data() to load a data frame from the a package
data(murders)

#create a murder rate vector (murders per 100,000 people)
murder_rates<-murders$total/murders$population*100000

#create a murder rate vector (murders per 100,000 people) and add it to the murders data frame
murders$murder_rates<-murders$total/murders$population*100000



