#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")


#libraries 
library(tidyverse)

#new package- run this once on your computer
#install.packages("skimr")

#then you can load the library
library(skimr)

#data for today
data("gss_cat")


#Examining  variables

#we can use the summmary() function 
summary(gss_cat) #this will give summmary statistics for all of the variables in your dataset

#you can also summmarize one variable at a time
summary(gss_cat$tvhours)


#the skimr package gives better summary statistics (reports number of missing cases)
skim(gss_cat)

#we can investigate further why tvhours is missing

gss_cat%>%
  filter(is.na(tvhours))%>% #we are going to skim cases where tv hours is missing
  skim() 


gss_cat%>%
  filter(!is.na(tvhours))%>% # we are going to skim cases where tv hours is not missing
  skim()


##Plots for Summarizing a Single Quantitative Variable

#Histogram
ggplot(data = gss_cat,
       mapping=aes(x=tvhours))+
  geom_histogram() 

#adjusting bin location and width
ggplot(data = gss_cat, mapping=aes(x=tvhours)) +
  geom_histogram(boundary=0, binwidth=1) #first bin starts at 0, bins are 1 unit wide

#a better histogram?
ggplot(data = gss_cat, mapping=aes(x=tvhours)) +
  geom_histogram(boundary=0, binwidth=1) #first bin starts at 0, bins are 4 units wide


##Exercise ##
#make a histogram for age, then adjust the bin width as needed
ggplot(data=gss_cat,
       mapping=aes(x=age))+
  geom_histogram( binwidth=10)



#Density plot
ggplot(data = gss_cat,
       mapping=aes(x=tvhours))+
         geom_density()

#adjusting the bandwidth (smoother density)
ggplot(data = gss_cat,
       mapping=aes(x=tvhours))+
  geom_density(adjust=2) #this is similar to making larger bins in a histogram



##Exercise ##
#make a density plot for age, then adjust the bandwidth as needed
ggplot(data=gss_cat,
       mapping=aes(x=age))+
  geom_density()


#Categorical Variables

#summary() will only show the top 6 levels of a factor variable if you are summarizing the entire data frame
summary(gss_cat)

#you will see all the levels if you summarize a single factor variable (relig)
summary(gss_cat$relig)

#skim() will tell you how many levels, but won't report all the levels
skim(gss_cat)

#dplyr is the best way to get a nice frequency table
marital_count<-gss_cat%>%
  count(marital)%>% #the count() function will create a variable called n 
 arrange(desc(n)) #sort the frequency table by the count variable (n)

#we can use the summarize() function from dplyr to make the same table
marital_summarize<-gss_cat%>%
  group_by(marital)%>% #we have to use group_by to get counts by marital status
  summarize(freq=n())%>% #we have to specify the name of the variable (freq) that will record the counts
  arrange(desc(freq)) #sort frequency table by the count variable (freq)

###Exercise###
#Create a frequency table for relig. Sort the levels from most to least frequent
relig_count<-gss_cat%>%
  count(relig)%>%
  arrange(desc(n))
  


#we can create a bar plot using our frequency table
ggplot(data=marital_count,
       mapping=aes(x=marital, y=n))+
  geom_col()

#we can arrange the levels by frequency using fct_infreq()
ggplot(data = marital_count,
       mapping=aes(x= fct_infreq(marital,n), #the first argument is the factor variable, the second is the frequency variable
                   y=n ))+
  geom_col()

  
  
###Exercise###
#Create a bar chart for relig using geom_col(). Display the levels by frequency.
  ggplot(data=relig_count,
         mapping=aes(x=fct_infreq(relig,n), y=n))+
  geom_col()

#you can use the original data (gss_cat) and ask ggplot to count the frequencies
ggplot(data = gss_cat,
       mapping=aes(x=marital)) +
  geom_bar()

#you can still order by frequency using fct_infreq()
ggplot(data = gss_cat,
       mapping=aes(x=fct_infreq(marital))) + #the only argument is the factor variable because ggplot will calculate the frequencies
  geom_bar()

#we can rotate the bar plot horizontally
ggplot(data = gss_cat,
       mapping=aes(x=fct_infreq(marital))) + #the only argument is the factor variable because ggplot will calculate the frequencies
  geom_bar()+ #we use a plus sign to continue to the next line
  coord_flip() #this flips the x and y axis


###Exercise###
#Create a bar chart for relig using geom_bar(). Display the levels by frequency. Rotate the bars so they're horizontal.
ggplot(data = gss_cat,
       mapping=aes(x=fct_infreq(relig))) + #the only argument is the factor variable because ggplot will calculate the frequencies
  geom_bar()+ #we use a plus sign to continue to the next line
  coord_flip() #this flips the x and y axis
