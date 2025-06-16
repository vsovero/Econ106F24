#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(tidyverse)
library(nycflights13) #you will need to install this package first (install.packages("nycflights"))

#data for today

#we're creating some data "from scratch"
superheroes <- tibble::tribble(
  ~name, ~alignment,  ~gender,          ~publisher,
  "Magneto",      "bad",   "male",            "Marvel",
  "Storm",     "good", "female",            "Marvel",
  "Mystique",      "bad", "female",            "Marvel",
  "Batman",     "good",   "male",                "DC",
  "Joker",      "bad",   "male",                "DC",
  "Catwoman",      "bad", "female",                "DC",
  "Hellboy",     "good",   "male", "Dark Horse Comics"
)

publishers <- tibble::tribble(
  ~publisher, ~yr_founded,
  "DC",       1934L,
  "Marvel",       1939L,
  "Image",       1992L
)


data(flights)
data("weather")

#left join (keep every row in the left data, even if there is no match)
all_superheroes <-left_join(x=superheroes, #data on the "left"
                            y=publishers, #data on the "right"
                            by="publisher") #primary key

#inner join (only keep rows in the left data that can be matched)
match_superheroes<-inner_join(x=superheroes, #data on the "left"
                              y=publishers, #data on the "right"
                              by="publisher") #primary key

#anti join (only keep rows in the left data that cannot be matched)
no_match_superheroes<-anti_join(x=superheroes, #data on the "left"
                              y=publishers, #data on the "right"
                              by="publisher") #primary key

#order matters (which data you specify as left, right)
all_publishers<-left_join(x=publishers,
          y=superheroes, 
          by="publisher")

#best practice: your "main data" goes on the left, do a left join
all_superheroes <-left_join(x=superheroes, #data on the "left"
                            y=publishers, #data on the "right"
                            by="publisher") #primary key


#NYC flights example
flights_with_weather<-left_join(x=flights,
                                y=weather,
                                by=c("origin", "year","month", "day", "hour","time_hour"))

#same join as above, but we don't specify time_hour as a key
flights_with_weather_no_time<-left_join(x=flights,
                                        y=weather,
                                by=c("origin", "year","month", "day", "hour"))

#the really bad join: we don't specify the primary key (don't include hour)
flights_with_weather_many<-left_join(x=flights,
                                     y=weather,
                                     by=c("origin", "year","month", "day"))

#we can let R identify the primary key (leave out the by argument)
flights_with_weather_no_by<-left_join(x=flights,
                                y=weather)


#Class Exercise

coverage <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-coverage.csv',
                     skip=2 ,
                     n_max=52, 
                     na="N/A")

coverage_messy <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-coverage.csv',
                    )


spending <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-spending.csv', 
                     skip = 2, 
                     n_max  = 52)


coverage_long<-coverage %>%
  pivot_longer(-Location,         ## Use all columns BUT 'Location'
               names_to = "year_type", 
               values_to = "tot_coverage")

coverage_sep <- coverage_long %>% 
  separate(year_type, sep="__", ## separate the year_type variable into two columns
           into = c("year", "type"), 
           convert=TRUE) #add this option to allow the new variables to be numeric if that's more appropriate


# take spending data from wide to long (stack spending into a single column)
spending_long<-spending %>%
  pivot_longer(-Location,         ## Use all columns BUT 'Location'
               names_to = "year_type", 
               values_to = "tot_spending")



# separate year and name columns
spending_sep <- spending_long %>% 
  separate(year_type, sep="__", ## separate the year_type variable into two columns
           into = c("year", "type"), 
           convert=TRUE) #add this option to allow the new variables to be numeric if that's more appropriate



#Left join coverage_sep and spending_sep, call it coverage_left
coverage_left<-left_join(x=coverage_sep, y=spending_sep, by=c("Location", "year"))



#Create a data frame of all the observations in the coverage data that cannot be matched to the spending data



#Create a data frame of all the observations in the spending data that cannot be matched to the coverage data







  