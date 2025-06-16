#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(tidyverse)
# you will first need to install the new packages
install.packages("cspp")
install.packages("ggrepel")

library(cspp) 
library(ggrepel)


#get healthcare variables from the cspp package
cspp_data <- get_cspp_data(vars=c("poptotal", "percentuninsured", "wellbeing", "sdce", "doctorsPerCapita","higrenew", "popgovhealthins", "popnohealthins", "popprivhealthins", "hmdindex", "health_pro" ),
                           years = seq(2010,2010))


#the basic scatter plot
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()


#add labels to your plot
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' ) 



#add a line of best fit (shows estimated line and 95% CI band)
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  geom_smooth()

#we can make it a straight line of best fit
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  geom_smooth(method="lm") #add the method argument and choose lm (linear method)


##Exercise###
#Create a scatter plot with doctorsPerCapita on the x-axis and wellbeing on the y axis
#add a line of best fit (try linear and nonlinear).



#we can label our points using geom_label()
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  geom_label(aes(label=st))

#we can use geom_label_repel when the labels start to overlap one another
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  geom_label_repel(aes(label=st))

#please don't do this (way too much clutter)
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point()+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  geom_hline(yintercept=25, color='red')+
  geom_label_repel(aes(label=st))+
  geom_vline(aes(xintercept=mean(percentuninsured, na.rm=TRUE), color="red"))+
  geom_smooth(method="lm")


##Class Exercise
#label the states on your scatter plot of doctors per capita and wellbeing


#we can set the scales (axis tick marks)
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  scale_y_continuous(breaks=seq(0,50, by=5))


#color scales (quantitative color mapping)
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point(aes(color=doctorsPerCapita))+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )


#we can select the color scale
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point(aes(color=doctorsPerCapita))+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  scale_color_gradient(low="red",  high="green")


###Class Exercise###
#Create a scatter plot with doctors per capita on the x-axis and well being on the y axis
#color the points with percent uninsured using a green and red gradient (green- low, red-high)





#first convert sdce to a factor variable
cspp_data <- cspp_data%>%
  mutate(dependent_coverage=factor(sdce, levels=0:1, labels=c("no", "yes")))

#ggplot choose an appropriate color scale for factor variables
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point(aes(color=dependent_coverage))+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )


#we can manually define our color choices for categorical data
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point(aes(color=dependent_coverage))+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  scale_color_manual(values=c("purple", "green"))


#we can select a color palette, which will determine the color choices
ggplot(data=cspp_data,
       mapping=aes(x=percentuninsured, y=wellbeing))+
  geom_point(aes(color=dependent_coverage))+
  labs(title = 'States Rank Higher in Well Being When There Are Fewer Uninsured',
       x = 'Percent of State Population that is Uninsured', 
       y = 'State Well Being Ranking' )+
  scale_color_brewer(palette="Set1") #the first two colors in this palette will be selected

