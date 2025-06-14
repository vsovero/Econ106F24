######################### Data wrangling in R ######################
#### Based on the data carpentry ecology lessons: 
####       http://www.datacarpentry.org/R-ecology-lesson/03-dplyr.html


#installing packages
install.packages("tidyverse")

#load the tidyverse package
library(tidyverse)

#read in the starwars data from the tidyverse package
data(starwars)


############################## The Verbs! ################################


### Filter
short_characters<- filter(starwars, height<180) #arguments: the data frame () and the logical condition


#pipes
short_characters<- surveys %>%       #the data then
  filter(height < 180) %>%           #filter for rows where height is less than 180
  
  
  #combining logical conditions ("and")
  tallish <- starwars %>%
  filter(height >= 190 & height <= 250 ) #we use & if we want cases where both conditions have to be met


#combining logical conditions ("or")

extremes <- starwars %>%
  filter(height <= 160 | height >= 190 ) #we use | if we want cases where either condition is met


#Exercise

#find the first and third quartile of the mass variable(hint: try summary())

#filter for characters who fall within the first and third quartile



#we can also filter based on non-numeric values

humans <- starwars %>%
  filter(species=="Human") #put quotes for values of non-numeric variables

#combining logical conditions with "or"
blue_black<- starwars %>%
  filter(eye_color=="blue" | eye_color=="black")

#the %in% operator is helpful for longer lists of "or" conditions
droid_humans_hutt <- starwars %>%
  filter(species %in% c( "Human" , "Droid" , "Hutt" ))

#you can also filter for what you don't want ("not")
not_human<- starwars %>%
  filter(species!="Human")

#Exercise: what's wrong with these commands?
mistake1<- starwars %>%
  filter(species=="human")


mistake2<- starwars %>%
  filter(species=="Human" | "Droid" )


###filtering for missing data cases
missing_heights <- starwars %>%
  filter(is.na(height)) #this keeps cases where height is missing


non_missing_heights <- starwars %>%
  filter(!is.na(height)) #this keeps cases where height is not missing

#Exercises
#create a data frame of the characters whose sex is listed as none

#create a data frame of the characters whose sex is unknown (missing)

#we can filter based on values of more than one variable
tall_humans <- starwars %>%
  filter(species=="Human") %>% #this pipe is needed to keep the command going to the next line
  filter(height >= 190)

#this also works
tall_humans <- starwars %>%
  filter(species=="Human", height >= 190)  #separate conditions with a comma when it's a different variable

###arrange

ascending_birth_year<- starwars %>%
  arrange(birth_year) #sorts data from lowest to highest value of birth_year


descending_birth_year<- starwars %>%
  arrange(desc(birth_year)) #sorts data from highest to lowest value of birth_year

##Exercise
#Filter for Naboo characters. Who is the tallest?


###Select
fewer_vars1<- starwars %>%
  select(mass, species, height) #list out the variables separated by commas

fewer_vars2<- starwars %>%
  select(height:eye_color, -skin_color) #everything between height and eyecolor, not skin color

color_vars<- starwars %>%
  select(contains("color")) #select variable names that contain the word "color"

###Mutate

add_new_vars<- starwars %>%
  mutate(dog_years=birth_year*7) %>% #put a pipe if you are adding a separate mutate function below
  mutate(height_m=height/100)


add_new_vars<- starwars %>%
  mutate(dog_years=birth_year*7, #or keep everything in the same mutate function and separate by commas
         height_m=height/100)

#you can create some non-numeric variables as well
add_height_vars<- starwars %>%
  select(name, height) %>%
  mutate(tall1 = height > 180,  #creates a variable with TRUE/FALSE values
         tall2 = ifelse(height > 180, "Tall", "Short")) #creates a variable with Short/Tall values

#why doesn't this work?
hmm<- starwars %>%
  select(name, mass) %>%
  arrange( height)

##Exercise

#calculate the BMI of the star wars characters
#filter for non-human characters
#sort them from highest to lowest BMI

