#load tidyverse
library(tidyverse)

#load starwars data frame
data(starwars)


#calculate mean height
height_summary <- starwars %>%
  summarize(mean_height = mean(height))


#calculate mean height, but remove NA values from the calculation
height_summary_without_NA <- starwars %>%
  summarize(mean_height = mean(height , na.rm=TRUE)) #we add na.rm=TRUE to tell R to ignore missing values in the calculation

#we also could have done it using Base R (result is a vector)
height_summary_without_NA <- mean(starwars$height, na.rm = TRUE) 


#you can create a summary table for multiple variables
ht_and_wt_summary <- starwars %>%
  summarize(mean_height = mean(height , na.rm=TRUE),
            mean_weight = mean(mass , na.rm=TRUE)
            )

#Exercise
#Calculate median and mean mass for characters in Naboo. 


###Frequency Tables (categorical variables)

#frequency table of species
species_count <- starwars %>%
  count(species) #this will create a variable called n that counts the frequencies

#frequency table of species ordered by frequency
species_count_ordered<- starwars %>%
  count(species)%>%
  arrange(desc(n)) #we sort based on the count variable (n)
 
#frequency table of species ordered by frequency, remove count for when species is missing
species_count_remove_NA<- starwars %>%
  count(species) %>%
  arrange(desc( n)) %>%
  filter(!is.na (species)) #we want to filter out the row where species is missing

#let's make it a top ten table
species_top_ten <- starwars %>%
  count(species) %>%
  filter (!is.na(species)) %>%
  arrange(desc(n)) %>% #sort by frequency first
  slice_head(n=10) #then take the first ten rows


#Exercise
#filter out missing values of eye color, then make a frequency table of eye color
#create a table of the top ten frequencies of eye color

  

#we can also make frequency tables for two categorical variables
species_gender_frequency<- starwars %>%
  count(species, gender) #this will count the frequencies of all combinations of species and gender

#we can calculate group specific means
weight_by_sex <- starwars %>% 
  group_by(sex) %>% #this tells R what variable you want to group your table by (sex)
  summarize(mean_wt = mean(mass, na.rm = TRUE)) #this calculates the mean for every value of sex

#we can calculate means for each gender-sex combination
weight_by_gender_sex <- starwars %>% 
  group_by(gender,sex) %>%
  summarize(mean_wt = mean(mass, na.rm = TRUE))

#we can also use the group_by() function to make a frequency table
characters_by_homeworld<- starwars %>% 
  group_by(homeworld) %>% 
  summarize(count=n()) #when we use summarize, we have to assign a name to the new variable that will record the frequencies

##Final Exercise. Real data!
#we will load data from a tidytuesday challenge
#the data description can be found here: https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-03-05

#R can read in csv files directly from a URL using the read_csv() function (part of the tidyverse)
jobs_gender <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-05/jobs_gender.csv")

#first, calculate the overall mean of wage_percent_of_male

#next, calculate the mean of wage_percent_of_male by year. 

#next, calculate the mean of wage_percent_of_male by major_category

#in 2013, which major_category had the highest gender gap?

#in 2016, which major_category had the highest gender gap?

#what would you want to learn from this data?

