##Set up your working directory##

#Step 1. Make sure the file pane window shows your Econ 106 folder

#Step 2. Click Session<Set Working Directory<To Files Pane Location

#Step 3. Copy over the setwd() command to your script (mine is below, yours will be different)
setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Fall 2024/Econ 106")

#libraries
library(tidyverse)

##data for today (these will read in correctly if the files are in your working directory)

nytimes<-read_csv("NYtimes.csv")

flying<-read_csv("flying-etiquette.csv")

##if the file is not in your working directory, you will have to load it through the "point and click" option
#Select File>Open Dataset>From Text(readr)
#a new window will pop up where you browse to the file location 
#once the file is loaded, you can copy over the code from the console




#let's convert Education from character to factor
flying_factor<-flying%>%
  mutate(Education_f=factor(Education)) #we use the factor function


#Now we have more tools to inspect Education_f (Base R, which is why we use $ to reference the data frame and variable)
levels(flying_factor$Education_f) #note that the levels are ordered alphabetically

levels(flying_factor$Education) #this doesn't work because education is stored as character

summary(flying_factor$Education_f)

frequency_table<-flying_factor%>% #this is the dplyr way to check the frequencies
  count(Education_f)

nlevels(flying_factor$Education_f)


#the order of the levels is also plotted alphabetically
ggplot(data=flying_factor,
       mapping=aes(x=Education_f))+
  geom_bar(aes(fill=Education_f))



#we can reorder the levels when we create a factor variable

flying_factor_ordered<-flying_factor%>%
  mutate(Education_order=factor(Education, 
                                levels=c("Graduate degree", "Bachelor degree", "Some college or Associate degree", "High school degree", "Less than high school degree" )))


frequency_table_ordered<-flying_factor_ordered%>% #this is the dplyr way to check the frequencies
  count(Education_order)

#the order of the levels makes more sense now
ggplot(data=flying_factor_ordered,
       mapping=aes(x=Education_order))+
geom_bar(aes(fill=Education_order))


##Exercise
#convert `Do you ever recline your seat when you fly?` into a factor.
#order the levels from Always to Never
#make a bar graph of the frequencies

flying_recline_factor<-flying%>%
  mutate(recline_f=factor(`Do you ever recline your seat when you fly?`)) #we use the factor function

#check to see what the levels are before you order them
summary(flying_recline_factor$recline_f)

#order the levels
flying_recline_ordered<-flying%>%
  mutate(recline_order=factor(`Do you ever recline your seat when you fly?`, 
                                levels=c("Always", "Usually", "About half the time", "Once in while", "Never" )))

ggplot(data=flying_recline_ordered,
       mapping=aes(x=recline_order))+
  geom_bar(aes(fill=recline_order))


#we can combine levels using fct_recode 
#to do so, we'll create a new factor variable called surname
#we specify the levels for surname (Keeper and Taker)
#we assign the old levels to the new levels

nytimes_recode<-nytimes_factor%>%
  mutate(name_status_recode=fct_recode(name_status_f,  
                            "Keeper" ="husband took bride's name",  
                            "Keeper" ="keeping",
                            "Keeper" ="professionally",
                            "Changer" ="both names",
                            "Changer" ="hyphenated",
                            "Changer" ="other",
                            "Changer" ="taking",
                            "Changer" ="unclear"))

#a slightly different approach to collapsing levels
#You create a list of levels that go into each factor
nytimes_collapse<-nytimes_factor%>%
  mutate(surname=fct_collapse(name_status_f,
                              "Keeper" =c("husband took bride's name", "keeping","professionally"),
	                          	"Changer"=c("both names","hyphenated","other","taking", "unclear")))


##Exercise
#collapse levels of `How often do you travel by plane?` that correspond
#to once a month or anything more frequent into a single level called Monthly

#convert to a factor
flying_often_factor<-flying%>%
  mutate(how_often_f=factor(`How often do you travel by plane?`))

#check the levels
summary(flying_often_factor$how_often_f)

#fct_collapse
flying_often_collapse<-flying_often_factor%>%
  mutate(how_often_collapse=fct_collapse(how_often_f,
                              "Monthly" =c("A few times per month", "A few times per week","Every day", "Once a month or less"),
                              ))



#check the new levels
summary(flying_often_collapse$how_often_collapse)


#the lazy approach: you just want to lump all of the small levels together
nytimes_lump<-nytimes_factor%>%
  mutate(surname=fct_lump(name_status_f, n=3)) #this will keep the three largest levels, the rest will be lumped into an "other" level



##Exercise 
#create a new factor variable that groups everything but the two most frequent levels of `How often do you travel by plane?`




#we can create factors from numeric variables
#first, you should inspect the numeric variable you want to cut into intervals
summary(nytimes$bride_age) #this tells us the smallest value is 20, the largest is 90

nytime_age_cut<-nytimes%>%
mutate(bride_age_f = cut(bride_age,
                      breaks = c(20, 30, 40, 50, 60, 70, 80, 90), #this sets the interval cut points
                      include.lowest = T,
                      right = F))

nytime_age_interval<-nytimes%>%
  mutate(bride_age_f = cut_interval(bride_age,
                           length = 10, #this sets the width of the interval
                           right = F))

