#set your working directory to the location of your 106 folder (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(sf)
library(tidyverse)

#data
CA_Counties<-st_read("california_counties/CaliforniaCounties.shp")

#if this doesn't work, move all the files to your 106 folder
CA_Counties<-st_read("CaliforniaCounties.shp")


class(CA_Counties)

# Check the CRS of the shapefile
st_crs(CA_Counties)

#let's plot the data using ggplot
ggplot(data=CA_Counties)+ #we don't include the mapping argument because ggplot knows to use the geometry column
  geom_sf() # this is the simple features geom (use whenever you have a data frame with sf)

#we can adjust the border color
ggplot(data=CA_Counties)+
  geom_sf(color='purple')

#we can also adjust the fill color
ggplot(data=CA_Counties)+
  geom_sf(color='purple', fill='green')

#we can color the counties based on values of a variable (median age)
ggplot(data=CA_Counties)+
  geom_sf(aes(fill=MED_AGE))#remember to add  aes() when referencing a variable name

#mess with the color gradient 
ggplot(data=CA_Counties)+
  geom_sf(aes(fill=MED_AGE))+
  scale_fill_gradient(low="yellow",  high="purple") #manually select the high and low color

ggplot(data=CA_Counties)+
  geom_sf(aes(fill=MED_AGE))+
  scale_fill_viridis_c(option = "plasma", direction=-1) #this looks nice (more contrast)


##Class Exercise
#let's color map to AVE_HH_SZ (low color is blue, high color is red)
ggplot(data=CA_Counties)+
  geom_sf(aes(fill=AVE_HH_SZ))+
  scale_fill_gradient(low="blue",  high="red")
#load excel file of GPS coordinates of college campuses into R

college_data <- read_csv("college locations.csv")

#select CSU's from this dataset
CSU_data <-college_data %>%
  filter(F1SYSNAM == "California State University")

# Convert CSU_data to a sf object 
CSU_sf <- st_as_sf(CSU_data, coords = c("LONGITUD", "LATITUDE"), crs = 4269)

#let's plot it
ggplot(data=CSU_sf) + #plots the coordinates on an empty grid
  geom_sf() 


#we can plot data from multiple sources
ggplot() + # the data argument moves out of ggplot and into the specific layers
  geom_sf(data=CA_Counties ) + #this gives the county borders
  geom_sf(data= CSU_sf) #this gives the csu locations

#points layers have to go after the border layer, otherwise the points get covered
ggplot() +
  geom_sf(data=CSU_sf ) +
  geom_sf(data= CA_Counties)


#Data Wrangling
#if we subset the data, the new data frame will still have sf
LA_County<-CA_Counties%>%
  filter(NAME=="Los Angeles")

class(LA_County)

#we will get a map of LA county
ggplot(data=LA_County) +
  geom_sf()

#let's make it purple
ggplot(data=LA_County) +
  geom_sf(fill="purple")

#joins with spatial data

#let's read in a csv file of county level college data
county_college<-read_csv("cty_coll_rP_gP_p25.csv")

#we have to create a column for the county codes (the linking variable)
county_college_fips<-county_college%>%
  mutate(CountyFIPS=str_replace(cty,"cty", "")) 

#we always put the data frame with sf on the left (as x)
CA_Counties_x<-left_join(x=CA_Counties, y=county_college_fips)

#check that it's a data frame with simple features
class(CA_Counties_x)

#don't do this (it won't recognize the geometry column as sf)
CA_Counties_y<-left_join(x=county_college_fips, y=CA_Counties)

#check the class (no simple features)
class(CA_Counties_y)

ggplot(data=CA_Counties_x) +
  geom_sf(aes(fill=College_Graduation_Rate_rP_gP_p25) ) 


#Class Exercise
#filter for UC campuses (not office of the president)
UC_data <-college_data %>%
  filter(F1SYSNAM == "University of California")%>%
  filter(IALIAS!="UCOP")


#convert to a sf data frame

# Convert CSU_data to a sf object 
UC_sf <- st_as_sf(UC_data, coords = c("LONGITUD", "LATITUDE"), crs = 4269)



#layer the points on the county map of California using ggplot

#color the UC campuses white
#color the CSU campuses red
#fill the counties based on the proportion of college graduates
#Do counties with a UC campus or CSU campus have more college graduates?
  

#we can plot data from multiple sources
ggplot() + # the data argument moves out of ggplot and into the specific layers
  geom_sf(data=CA_Counties_x, aes(fill=College_Graduation_Rate_rP_gP_p25) ) + #this gives the county borders
  geom_sf(data= CSU_sf, color="red")+
  geom_sf(data= UC_sf, color="white")+
  scale_fill_viridis_c(option = "plasma", direction=-1) #this looks nice (more contrast)

  