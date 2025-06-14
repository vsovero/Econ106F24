
#packages needed today
library(tidyverse)
library(dslabs)

#data for today
jobs_gender <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-05/jobs_gender.csv")
data(diamonds)
safer_parks <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/saferparks.csv")


# the simplest ggplot: data, aesthetic mappings, and geometry
ggplot(data = diamonds, 
       mapping=aes(x = carat, y = price)) + 
  geom_point()


#we can use color to display additional information (color mapping)
ggplot(data = diamonds, 
       mapping= aes(x = carat,  y = price)) + 
  geom_point(aes(color = clarity)) #remember to use aes() whenever you reference a variable


#we can color map line graphs 
gapminder %>%
  filter(region=="South America") %>%
  ggplot(mapping=aes(x=year, y=fertility)) +
  geom_line(aes(color=country)) #create a separate line for each country with a unique color

#color setting: assigning a fixed color to the entire graph
ggplot(data = diamonds, 
       mapping= aes(x = carat, y = price))+ 
  geom_point(color = "blue")

#color mapping: mapping values of a variable to a distinct color
ggplot(data = diamonds, 
       mapping= aes(x = carat, y = price))+ 
  geom_point(aes(color = clarity))


###Exercise
#Use the jobs_gender data frame to create a scatter plot of total_earnings on the x-axis and wage_percent_of_male on the y-axis, 
#color mapping by major_category



###Exercise
#Use the jobs_gender data frame to create a scatter plot of total_earnings on the x-axis and wage_percent_of_male on the y-axis
#map total_workers to size, choose alpha equal to .2




## plotting categorical variables

#bar plot of a single variable has the values of the variable on the x-axis and the frequency on the y-axis


computer_engineering_science<-jobs_gender%>%
  filter(major_category=="Computer, Engineering, and Science")

#if you have a dataset that has a frequency variable, you will use geom_col()
ggplot( data=computer_engineering_science, mapping=aes(x=minor_category, y=total_workers)) +
  geom_col() #this puts every value of minor_category on the x-axis and sums up the total workers within each category


#when our data does't have frequencies, we ask ggplot to count for us
ggplot(data = diamonds,
       mapping=aes(x=cut))+
  geom_bar() #this will count the frequencies of your x variable (cut)

##Exercise
#use the safer_parks data frame to show the breakdown of injuries by industry sector


#we can color map with bar charts

#color is mapped to values on the x-axis
ggplot(data = diamonds,
       mapping=aes(x=cut))+
  geom_bar(aes(fill=cut)) #we use fill instead of color because a bar is a 2d shape)

#Exercise
#use the safer_parks data frame to show the breakdown of injuries by industry sector
#color the bars by industry sector


#we can use color to provide  frequencies of an additional categorical variable
ggplot(data=diamonds,
       mapping= aes(x=clarity)) + #clarity is still on the x-axis
  geom_bar(aes(fill=cut)) #this breaks down the clarity counts further by cut


##Exercise
#use the safer parks data frame, filter for amusement ride
#keep only injuries with gender reported as male or female 


#create a bar graph of device category colored by gender



#use the safer parks data frame, filter for amusement rides
#keep only injuries with gender reported as male or female 
#create a bar graph of gender broken colored by device category



#we can plot the same information, but this time don't stack the bars vertically
ggplot(data=diamonds,
       mapping= aes(x=clarity)) + #clarity is still on the x-axis
  geom_bar(aes(fill=cut), position="dodge") #the position argument tells R how to lay out the bars (as a group instead of stacked) 

#let's make a stacked barplot with proportions instead of counts
ggplot(data=diamonds,
       mapping= aes(x=clarity)) + #clarity is still on the x-axis
  geom_bar(aes(fill=cut), position="fill") #the position argument tells R how to lay out the bars (fill in the bars as proportions) 



#use the safer parks data frame, filter for amusement rides
#keep only injuries with gender reported as male or female 
#create a bar graph of gender broken colored by device category (proportions)
