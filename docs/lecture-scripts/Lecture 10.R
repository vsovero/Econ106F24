#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(tidyverse)

#data for today
data("gss_cat")


#Descriptive analysis

#density plot for a quantitative variable
ggplot(data = gss_cat,
       mapping=aes(x=tvhours)) +
  geom_density(adjust=2)

#bar plot for a categorical variable
ggplot(data=gss_cat,
       mapping= aes(x=partyid))+ 
  geom_bar()+
  coord_flip()

#let's clean up partyid by removing don't know, no answer, other party and then combining levels

gss_party<-gss_cat %>%
  filter(partyid!="Don't know")%>% #dropping cases where partyid is don't know, other, or no answer
  filter(partyid!="Other party")%>%
  filter(partyid!="No answer")%>%
  mutate( party_3 = fct_collapse(partyid,
                                     "rep" = c("Strong republican", "Not str republican"),
                                     "ind" = c("Ind,near rep", "Independent", "Ind,near dem"),
                                     "dem" = c("Not str democrat", "Strong democrat")))
             

#bar graph looks better now

ggplot(data=gss_party,
       mapping= aes(x=party_3))+ 
  geom_bar(aes(fill=party_3))
  

#Exploring the relationship between a quantitative and a categorical variable

#density plot of tvhours for each level of party_3
ggplot(data = gss_party,
       mapping=aes(x=tvhours))+ #tvhours is the quantitative variable
  geom_density(adjust=2, aes(color=party_3)) #party_3 is the categorical variable

##Exercise###
#filter out cases where marital is "No answer"
#create a new factor variable called marry_fewer that has three levels, married, previously married, never married
summary(gss_party$marital)

gss_marry<-gss_party%>%
  filter(marital!="No answer")%>%
  mutate(marry_fewer=fct_collapse(marital, 
                                  "Previously married"=c("Separated", "Divorced", "Widowed")))

#create a density plot of age for each level of marry_fewer
ggplot(data=gss_marry,
       mapping=aes(x=age))+
  geom_density(aes(fill=marry_fewer), alpha=.4)



#we can facet (put each density on it's own plot)
ggplot(data=gss_party, mapping=aes(x=tvhours))+
  geom_density(adjust=2, aes(color=party_3))+
  facet_wrap(~party_3)

#if you have a lot of levels, they will "wrap" over to a new row
ggplot(data = gss_party,
       mapping=aes(x = tvhours))+
  geom_density(adjust=2, aes(color=partyid))+
  facet_wrap(~ partyid)

#if you want everything on a single row or single column, use facet_grid()
ggplot(data = gss_party,
       mapping=aes(x = tvhours)) +
  geom_density(adjust=2, aes(color=party_3)) +
  facet_grid(.~ party_3) #this puts everything in a single row

ggplot(data = gss_party,
       mapping=aes(x = tvhours)) +
  geom_density(adjust=2, aes(color=party_3)) +
  facet_grid(party_3~ .) #this puts everything in a single column

##Exercise
#created a faceted graph of age density by marry_fewer. All of the plots should be in a single column
ggplot(data = gss_marry,
       mapping=aes(x = age)) +
  geom_density(aes(fill=marry_fewer), alpha=.4)+
  facet_grid(marry_fewer~party_3)



#Instead of showing the whole distribution of tv hours by party_3, we compare some summary statistics of tv hours by party_3

#we first create a summary table of the mean and sd of tv hours by party_3
tv_summary<-gss_party%>%
  group_by(party_3)%>%
  summarize(mean_tv=mean(tvhours, na.rm=TRUE), 
            sd_tv=sd(tvhours, na.rm=TRUE))

#then we use geom_col to plot the data from the summary table
ggplot(data=tv_summary,
       mapping=aes(x = party_3, y = mean_tv)) +
  geom_col(aes(fill=party_3)) 

#we can add in error bars to represent sd
ggplot(data=tv_summary,
       mapping=aes(x = party_3, y = mean_tv)) +
  geom_col(aes(fill=party_3))+
  geom_errorbar(aes(ymin=mean_tv-sd_tv, ymax=mean_tv+sd_tv))


#another way to show summary statistics for tv hours is through a box plot
ggplot(data=gss_party, 
       mapping=aes(x=party_3, y=tvhours))+
  geom_boxplot(aes(fill=party_3))

###Exercise###
#Create a boxplot of age for each level of marry_fewer
ggplot(data=gss_marry, 
       mapping=aes(x=marry_fewer, y=age))+
  geom_boxplot(aes(fill=marry_fewer))


#Exploring relationships between 2 categorical variables

#stacked barplot
ggplot(data=gss_party,
       mapping= aes(x=race)) + 
  geom_bar(aes(fill=party_3))

#barplot with proportions
ggplot(data=gss_party,
       mapping= aes(x=race))+ 
  geom_bar(aes(fill=party_3), position ="fill")



###Exercise###
#create a stacked barplot of the proportions of marry_fewer by party_3


#barplot (unstacked)
ggplot(data=gss_party,
       mapping= aes(x=race))+ 
  geom_bar(aes(fill=party_3), position ="dodge")

#we can obtain a similar unstacked barplot by faceting
ggplot(data=gss_party,
       mapping= aes(x=party_3)) + 
  geom_bar(aes(fill=party_3))+
  facet_wrap(~race)

##Exercise##
#create a faceted barplot of marital status by political affiliation
