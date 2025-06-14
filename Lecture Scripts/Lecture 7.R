
#libraries for today
library(tidyverse)
library(dslabs)
library(rvest) #this is just to load an example data frame

#data for today
coverage <- read_csv('https://raw.githubusercontent.com/opencasestudies/ocs-healthexpenditure/master/data/KFF/healthcare-coverage.csv', 
                     skip = 2,
                     n_max  = 52) 

transit_cost <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-05/transit_cost.csv')

data(table3)

#note: this is an example of pulling data from a wikipedia page (you don't have to worry about the details)
url <- paste0("https://en.wikipedia.org/w/index.php?title=",
              "Gun_violence_in_the_United_States_by_state",
              "&direction=prev&oldid=810166167")
murders_raw <- read_html(url) |>
  html_node("table") |>
  html_table() |>
  setNames(c("state", "population", "total", "murder_rate"))


nyc_squirrels <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-29/nyc_squirrels.csv")


#referencing variable names that "break the rules"
large_uninsured_states<- coverage %>%
  filter(Location!="United States")%>% #we don't have to write `Location` because the variable name doesn't violate naming rules
  filter (`2016__Uninsured`>=1000000) #we do have to write `2016__Uninsured`  because variable names shouldn't start with a number
  
#we will use  as.numeric() to coerce the following variables to numeric
coverage_coerce <- coverage %>%
  mutate(`2016__Other Public`=as.numeric(`2016__Other Public`), #for simplicity we are reusing the variable name in the new data frame
         `2015__Other Public`=as.numeric(`2015__Other Public`), #we can create multiple variables within mutate(), just separate by commas
         `2014__Other Public`=as.numeric(`2014__Other Public`),
         `2013__Other Public`=as.numeric(`2013__Other Public`))



#Exercise
#Examine the end_year variable in the transit_cost data frame. Why is it stored as character?  Convert it to numeric.
transit_cost_numeric<-transit_cost%>%
  mutate(end_year_numeric=as.numeric(end_year))


#This is a situation where you shouldn't use coercion to convert the rate variable to numeric
table3_coercion <- table3 %>%
  mutate(rate=as.numeric(rate))

#in this data frame, we need to separate the values of rate into two columns
table3_separated <- table3%>%
  separate(col=rate,  #this is the variable you want to separate
           into = c("cases", "population"),  #these are the names you provide for the new variables
           sep = "/", #this is the string where the rate variable will be split at
	convert=TRUE) #this tells R to convert the new variables to numeric if appropriate



#the murders_raw data frame has a population variable filled with commas
murders_clean<-murders_raw%>%
  mutate(new_population=str_replace_all(population,",", ""), #we will replace all commas to missing (erase them)
        numeric_population=as.numeric(new_population)) #then we will make a numeric version of this variable


#Examine the tunnel_per variable in the transit cost data frame. Why is it stored as character? Convert it to numeric.
transit_cost_percent<-transit_cost%>%
  mutate(tunnel_percent=str_replace_all(tunnel_per,"%",""),
         tunnel_percent_numeric=as.numeric(tunnel_percent))

#numeric vectors can be converted to date (special type of numeric)
squirrel_date<-nyc_squirrels%>%
  mutate(date_converted=mdy(date))

#this makes it easier to pull out components of the date
squirrel_month<-squirrel_date%>%
  mutate(month_factor=month(date_converted, label=TRUE),
         month_num=month(date_converted, label=FALSE))

###Exercise###
#Pull out day of the week as a factor variable
#Count the number of squirrel sightings by day of the week, filled by time of day (shift)

squirrel_day<-squirrel_date%>%
  mutate(day_factor=wday(date_converted, label=TRUE))

ggplot(data=squirrel_day,
       mapping=aes(x=day_factor))+
  geom_bar(aes(fill=shift))