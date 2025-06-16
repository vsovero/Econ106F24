
#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(tidyverse)
library(ggrepel)
library(cspp)

#install new package
install.packages("ggridges")
library(ggridges)

#data for today
cspp_data <- get_cspp_data(vars=c("poptotal", "percentuninsured", "wellbeing", "sdce", "doctorsPerCapita","higrenew", "popgovhealthins", "popnohealthins", "popprivhealthins", "hmdindex", "health_pro" ),
                           years = seq(2010,2010))

acs <- readRDS(url("https://sscc.wisc.edu/sscc/pubs/dvr/acs.rds"))

#last time: improving on the basic scatter plot
#the basic scatter plot
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()

#improved
ggplot(data=cspp_data,
       mapping=aes(x=popgovhealthins, y=percentuninsured))+
  geom_point(aes(size=poptotal, color=wellbeing), alpha=.7)+
  labs(title = 'Larger States have more uninsured and more using Public Health Insurance',
       x = 'Population using Government Health Insurance', 
       y = 'Percent of State Population that is Uninsured')+
  scale_x_continuous(breaks=seq(0,12000, by=1000))+
  scale_color_gradient(low="green",  high="red")

#use theme() to adjust non-data plot settings (font, legend)
ggplot(data=cspp_data,
       mapping=aes(x=popgovhealthins, y=percentuninsured))+
  geom_point(aes(size=poptotal, color=wellbeing), alpha=.7)+
  labs(title = 'Larger States have more uninsured and more using Public Health Insurance',
       x = 'Population using Government Health Insurance', 
       y = 'Percent of State Population that is Uninsured')+
  scale_x_continuous(breaks=seq(0,12000, by=1000))+
  scale_color_gradient(low="green",  high="red")+
  theme(text=element_text(size=12, family="Arial" ))

#you can also use themes to change the grid settings
ggplot(data=cspp_data,
       mapping=aes(x=popgovhealthins, y=percentuninsured))+
  geom_point(aes(size=poptotal, color=wellbeing), alpha=.7)+
  labs(title = 'Larger States have more uninsured and more using Public Health Insurance',
       x = 'Population using Government Health Insurance', 
       y = 'Percent of State Population that is Uninsured')+
  scale_x_continuous(breaks=seq(0,12000, by=1000))+
  scale_color_gradient(low="green",  high="red")+
  theme(text=element_text(size=12, family="Arial" ))+
  theme_bw()


#the basic bar plot
ggplot(data=acs, 
       mapping=aes(x = edu)) +
  geom_bar()


#add color (ggplot default color choices)
ggplot(data=acs, 
       mapping=aes(x = edu)) +
  geom_bar(aes(fill=edu))


#use fill for 2d shapes, otherwise only the outline gets color
ggplot(data=acs, 
       mapping=aes(x = edu)) +
  geom_bar(aes(color=edu))

#we can use color and fill at the same time
ggplot(data=acs, 
       mapping=aes(x = edu)) +
  geom_bar(aes(fill=edu), color="black")

#let's remove the legend because it's not adding any new information (labels are already on the x axis)
ggplot(data=acs,
       mapping= aes(x=edu))+
  geom_bar ( aes(fill=edu))+
  theme(legend.position = 'none')


#adjust color manually for 2-d shapes
ggplot(data=acs,
       mapping= aes(x=edu))+
  geom_bar ( aes(fill=edu))+
  theme(legend.position = 'none')+
  scale_fill_manual(values=c("red", "orange", "yellow", "green" ,"blue"))


#this works
ggplot(acs, aes(x = edu)) +
  geom_bar(aes(fill=edu), color="black")+
  scale_fill_brewer(palette= "Purples")

#this doesn't (why?)
ggplot(acs, aes(x = edu)) +
  geom_bar(aes(fill=edu), color="black")+
  scale_color_brewer(palette= "Purples")

#Class Exercise
#make a bar plot for race. 
#choose the Set1 color brewer palette



#Sequential Color Palette
ggplot(data=acs,
       mapping=aes(x=edu))+
  geom_bar(aes(fill=race), color="white", position="fill")+
  scale_fill_brewer(palette="Pastel1")+
  theme_bw()



#want to add text with the count to each bar? create a frequency table, then use geom_col
degree_frequency<-acs%>%
  count(edu)

#use geom_text to add the count to each bar
ggplot(data=degree_frequency, 
       mapping=aes(x = edu, y=n)) +
  geom_col(aes(fill=edu), color="black")+
  geom_text(aes(label = n))+  #this adds the values of the n column to the bar plot
  scale_fill_brewer(palette= "Purples")+
  theme(legend.position = 'none')

#use vjust to shift the position of the text
ggplot(data=degree_frequency, 
       mapping=aes(x = edu, y=n)) +
  geom_col(aes(fill=edu), color="black")+
  geom_text(aes(label = n), vjust  = -0.3)+ #we shift it slightly above the bars
  scale_fill_brewer(palette= "Purples")+
  theme(legend.position = 'none')


#Class Exercise
#make a bar plot for race. 
#choose the Set1 color brewer palette
#add the counts to the top of each bar


#let's calculate mean income by education
income_by_edu<-acs %>% 
  filter(!is.na(edu)) %>%
  group_by(edu) %>%
  summarize(mean_income = mean(income, na.rm = TRUE))


#we use geom_col to plot the means by education
ggplot(data=income_by_edu,
       mapping=aes(x = edu, y = mean_income)) +
  geom_col(aes(fill=edu)) +
  scale_fill_brewer(palette= "Purples", direction=-1)+
  theme(legend.position = 'none')


#add in the mean values as labels
ggplot(data=income_by_edu,
       mapping=aes(x = edu, y = mean_income)) +
  geom_col(aes(fill=edu)) +
  scale_fill_brewer(palette= "Purples")+
  theme(legend.position = 'none')+
  geom_text(aes(label = mean_income))


#add in the mean values as labels (round to whole numbers)
ggplot(data=income_by_edu,
       mapping=aes(x = edu, y = mean_income)) +
  geom_col(aes(fill=edu)) +
  scale_fill_brewer(palette= "Purples")+
  theme(legend.position = 'none')+
  geom_text(aes(label = round(mean_income)))

#adjust the position of the values
ggplot(data=income_by_edu,
       mapping=aes(x = edu, y = mean_income)) +
  geom_col(aes(fill=edu), color="black") +
  scale_fill_brewer(palette= "Purples")+
  theme(legend.position = 'none')+
  geom_text(aes(label = round(mean_income)), vjust=-.3)

#How do we make this better?
ggplot(data=acs,
       mapping=aes(x = age)) +
  geom_density(aes(color=maritalStatus))

#drop the NA's
acs_marital<-acs%>%
  filter(!is.na(maritalStatus))

#try fill, add some transparency
ggplot(data=acs_marital,
       mapping=aes(x = age)) +
  geom_density(aes(fill=maritalStatus), alpha=.5)

#faceting
ggplot(data=acs_marital,
       mapping=aes(x = age)) +
  geom_density(aes(fill=maritalStatus), alpha=.5)+
  facet_wrap(.~maritalStatus)


#Class Exercise
#filter for income less than 200,000
#make a density plot of income faceted by race

ggplot(data=acs,
       mapping=aes(x=income))+
  geom_density(aes(fill=race), alpha=.5)+
  facet_wrap(.~race)


#ridgelines
ggplot(data=acs_marital,
       mapping=aes(x = age, y=maritalStatus)) +
  geom_density_ridges(aes(fill=maritalStatus), alpha=.5)

#adjust the overlap
ggplot(data=acs_marital,
       mapping=aes(x = age, y=maritalStatus)) +
  geom_density_ridges(aes(fill=maritalStatus), alpha=.5, scale=3)

#ridgelines with color representing age
ggplot(data=acs_marital,
       mapping=aes(x = age, y=maritalStatus)) +
  geom_density_ridges_gradient(aes(fill=stat(x)), scale=3)

#use the viridis color scale
ggplot(data=acs_marital,
       mapping=aes(x = age, y=maritalStatus)) +
  geom_density_ridges_gradient(aes(fill=stat(x)), scale=3, alpha=.3)+
  scale_fill_viridis_c(option = "plasma", direction=-1)

#Class Exercise

#use the turbo color scale and ggridges for density of income by race



