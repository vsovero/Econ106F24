#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(tidyverse)

#data for today
data(table1)
data(table2)
data(table4a)
data(table4b)
data(table3)

#note: movies.csv must be in your working directory for this to load properly
movies<-read_csv("movies.csv")

###Exercise###
#Calculate the  case rate by country and year using table1
table1_case_rate<-table1%>%
  mutate(case_rate=cases/population,
         cate_rate_percent=case_rate*100)


#Can you do the same thing with table2?
#no, I can't do it. 



#reshaping wide to long (fewer columns, more rows)

wide_to_long <-table4a %>% 
  pivot_longer(c(`1999`, `2000`), #these are the name of the columns that need to be pivoted
               names_to = "year", #this is the name I am picking for the column that will store the year info
               values_to = "cases") #these are the values that that need to be stacked into a single column


wide_to_long_deselect <- table4a %>% 
  pivot_longer(-country, #these are the name of the columns that don't need to be pivoted
               names_to = "year", #this is the name I am picking for the column that will store the year info
               values_to = "cases") #these are the values that that need to be stacked into a single column

#reshaping long to wide (fewer rows, more columns)
long_to_wide<-table2%>%
  pivot_wider(names_from = type, #this is the column that contains the new variable names (cases, population)
              values_from = count) #this is the column that contains the values of cases and population


#separate (split values of a column into multiple columns)
table3_separated <- table3%>%
  separate(col=rate,  #this is the variable you want to separate
           into = c("cases", "population"),  #these are the names you provide for the new variables
           sep = "/", #this is the string where the rate variable will be split at
           convert=TRUE) #this tells R to convert the new variables to numeric if appropriate



movies_language <- movies %>%
  separate_rows(language, #this is the variable that you want to separate into rows
                sep = ',') #this the pattern to detect when a new row should be created



##Exercise
#use the genre variable to calculate the average domestic gross by genre
#keep the top 5 genres by domestic gross (no tidying)
top_5_untidy_genre<-movies%>%
  group_by(genre)%>%
  mutate(domgross_clean=as.numeric(domgross))%>%
  summarize(genre_mean=mean(domgross_clean, na.rm=TRUE))

#separate the genre variable
#calculate the average domestic gross by genre
#keep the top 5 genres by domestic gross



 