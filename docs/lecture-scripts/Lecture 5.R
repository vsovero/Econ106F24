## Code obtained from Data Carpentry Ecology Lesson
####  http://www.datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html

#packages needed today
library(tidyverse)
library(dslabs)


#we are using these three datasets during lecture
data(gapminder)
data("diamonds")
jobs_gender <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-05/jobs_gender.csv")



## Plotting numerical data 
#Basic graph elements

# the simplest ggplot: data, aesthetic mappings, and geometry
ggplot(data = diamonds, 
       mapping=aes(x = carat, y = price)) + 
  geom_point()

# Break it down into component parts

# Step 1: Initialize the plot
#- specify data
#- creates a blank plot

ggplot(data = diamonds)

# Step 2: specify variables on each axis
#- specify the "aesthetic mappings"
#- start with the aes function
#-opens a plot window and draws axes

ggplot(data = surveys_complete, 
       mapping = aes(x = carat,  y = price))

# Step 3: specify the geometry 
#- use a geom function to specify how the data should be plotted
# "add" aesthetics to the ggplot function with + operator
# adds data points to the plot

ggplot(data = diamonds, 
       mapping = aes(x = carat,  y = price))+
  geom_point()

##Exercise.
#Create a scatter plot with total_earnings on the x-axis and wage_percent_of_male on the y-axis




# Adding arguments to the geom to change appearance:

# Add transparency with the alpha argument to geom_pont
ggplot(data = diamonds, 
       mapping= aes(x = carat,  y =price)) +
  geom_point(alpha = 0.1)

# Add color with the color argument to geom_point
ggplot(data = diamonds, 
       mapping= aes(x = carat,  y =price)) +
  geom_point(alpha = 0.1,  color = "blue")


###Exercise
#Your boss requires that all scatter plots use triangle shapes and the cornflower blue color (“cyan”). 
#Adjust your scatter plot of total_earnings and wage_percent_of_male accordingly. 



#dplyr and ggplot
#you can use dplyr to filter your data frame
very_good_cut<-diamonds%>%
  filter(cut== "Very Good")

#then use the filtered data frame with ggplot
ggplot(data = very_good_cut, 
       mapping= aes(x = carat, y = price))+ 
  geom_point(alpha = 0.1, 
             color = "blue")

#another option is to "pipe" the results directly into ggplot
diamonds%>%
  filter(cut== "Very Good") %>% #this is where you "pipe" the results into ggplot
  ggplot( mapping= aes(x = carat, y = price))+ #we don't specify the data because it's being fed in from the previous line
  geom_point(alpha = 0.1, 
             color = "blue")

###Exercise
#Filter for occupations in computer, engineering, and science
#create a scatter plot of total_earnings and wage_percent_of_male 


#line graphs using gapminder (this looks pretty bad)
ggplot(data = gapminder,mapping=aes(x=year, y=fertility)) +
  geom_line()

#check the scatter plot first
ggplot(data = gapminder,
       mapping=aes(x=year, y=fertility)) +
  geom_point()

#line graphs using gapminder (line for each country)
ggplot(data = gapminder, 
       mapping=aes(x=year, y=fertility)) +
  geom_line(aes(group=country)) #we use the group argument to specify a separate line for each country

#first create a data frame for South American countries
South_America <- gapminder %>%
  filter(region=="South America")

#then plot the South_America data frame
ggplot(data = South_America,mapping=aes(x=year, y=fertility)) +
  geom_line(aes(group=country))


#if you don't want to create a separate data frame, you can wrangle directly into ggplot
gapminder %>% 
  filter(region=="South America")%>%  #we can use pipes to feed data into ggplot
ggplot(mapping=aes(x=year, y=fertility))+ #you don't need to specify the data argument when you pipe it in
  geom_line(aes(group=country))

##Exercise
#Create a line graph of occupations in architecture and engineering occupations showing percent_female by year

  

#we can collapse the data by continent and year
continent_summary<-gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_fertility=mean(fertility, na.rm=TRUE))
            
#then ggplot using the group argument
  ggplot(data=continent_summary,
         mapping=aes(x=year, y=mean_fertility)) +
  geom_line(aes(group=continent))

#Exercise
#calculate the mean percent_female by year and by minor_category for occupations in computer, engineering and science
#plot as a line graph
summary_table<-jobs_gender%>%
  filter(major_category=="Computer, Engineering, and Science")%>%
  group_by(minor_category, year)%>%
  summarize(mean_percent_female=mean(percent_female, na.rm=TRUE))

ggplot(data=summary_table,
       mapping=aes(x=year, y=mean_percent_female))+
  geom_line(aes(group=minor_category))

gapminder %>% 
  filter(region=="South America")%>%  #we can use pipes to feed data into ggplot
  ggplot(mapping=aes(x=year, y=fertility))+ #you don't need to specify the data argument when you pipe it in
  geom_line(aes(color=country))


#Exercise
#calculate the mean percent_female by year and by minor_category for occupations in computer, engineering and science
#plot as a line graph, color by minor_category

