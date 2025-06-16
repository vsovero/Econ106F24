##Template for Research Project Milestone 1


#load necessary libraries
library(tidyverse)

##set your working directory to the location of your data file



##read in your data file (easiest to load if it is saved as a csv file)
wcmatches <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-11-29/wcmatches.csv')



##Categorical Variables####


#show first ten values of categorical variable 1 (convert to factor then check # levels)
cat_1<-wcmatches%>%
  select(month)%>%
  mutate(month_factor=factor(month))
  

#show first ten values of categorical variable 2
categories_country <- wcmatches %>%
  select(country) %>%
  unique()

#show first ten values of categorical variable 3 
category_frequency <- wcmatches %>%
  count(country)

#show first ten values of categorical variable 4 



##Quantitative Variables####


#show first ten values of quantitative variable 1 
cat_1<-wcmatches%>%
  select(stage)%>%
  slice_head(n=10)

#show first ten values of quantitative variable 2 


#show first ten values of quantitative variable 3 


#show first ten values of quantitative variable 4 

