# code associated with exerpts of the data carpentry lessons
#http://www.datacarpentry.org/R-ecology-lesson/01-intro-to-R.html
#http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html

# R can do math!
3+5           #Prints 8 to the console
12/7          #prints 1.714286 to the console

#Exercise
#Louberto’s bill at Shake Shack came out to $25. He tips 15%. How much did he tip? 

#Lou’s bill at Shake Shack came out to $32. He tips 12%. How much did he tip? 



# Functions and their arguments 
## Functions have:
#   - Names
#   - Arguments - what they need to "know" to run that function; aka input; isn't modified
#   - Output - the result of whatever the function does; default is output to the console, 
#              can be assigned to variables; 

#Round is the function, x and digits are the arguments, output (3) goes to the console
round(x=3.14159, digits =0)

#you can drop default arguments and just enter the number you want to round, but I don't recommend this for beginners
round(3.14159)

# The assignment operator (<-): storing values in variables
weight_kg <- 25  

#this will overwrite the previous value stored in the weight_kg object
weight_kg <- 55

weight_kg <- 55    # doesn't print anything in the console
weight_kg          # typing the name of the object prints the value of weight_kg to the console


#Exercise
#Louberto’s bill at Shake Shack came out to $25. He tips 15%. Store these values as objects and then create a new
#object to calculate how much tip he left. 

#Lou’s bill at Shake Shack came out to $32. He tips 12%. Store these values as objects and then create a new
#object to calculate how much tip he left. 

#remove an object in your environment
rm(weight_kg)

#remove everything in your workspace
rm(list=ls())

#Assign a number value to an object
x<-32

#Assign text value to an object
y<-"hi"


