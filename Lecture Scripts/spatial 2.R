#set your working directory to the location of your 106 folder (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(sf)
library(tidyverse)
library(tigris)
library(units)

#last time: we loaded a shape file of the county borders in CA
CA_Counties<-st_read("california_counties/CaliforniaCounties.shp")


#Alternatively, we can download shape files using the Tigris package
CA_Counties_Tigris<-counties("California") #counties in CA

US_States_Tigris<-states() #all states and territories

#let's plot the US States and territories
ggplot(data=US_States_Tigris)+
  geom_sf() 

#let's drop territories, move Alaska and Hawaii closer
  only_states <- US_States_Tigris%>%
  filter(REGION != "9") %>% 
  shift_geometry()
  
#this looks better
  ggplot(data=only_states)+
    geom_sf()

#we can add labels to the map
  ggplot(data=only_states)+
    geom_sf()+
    geom_sf_label(aes(label=STUSPS))

#Class Exercise
#pull the Riverside county border and Riverside road network from Tigris


  #load the college locations csv
  college_data <- read_csv("college locations.csv")
  
  
  #select UC's from the college locations dataset
  UC_data <-college_data %>%
    filter(F1SYSNAM == "University of California")%>%
    filter(IALIAS!="UCOP")
  
  # Convert UC_data to a sf object 
  UC_sf <- st_as_sf(UC_data, coords = c("LONGITUD", "LATITUDE"), crs = 4269)
  
  #select UCR
  UCR<-UC_sf%>%
    filter(IALIAS=="UC Riverside")
  

  
  
  #create a map of all three objects
  
  
  
#Spot the differences between these two maps
ggplot()+
  geom_sf(data=CA_Counties_Tigris)


ggplot()+
  geom_sf(data=CA_Counties)


# Check the current CRS of the CA Counties shapefile
st_crs(CA_Counties)

# Check the current CRS of the CA Counties tigris shapefile
st_crs(CA_Counties_Tigris)


#let's use a projected CRS (Mercator)
CA_Counties_Tigris_Mercator<-st_transform(CA_Counties_Tigris, crs=3857)

#see how it looks
ggplot(data=CA_Counties_Tigris_Mercator) +
  geom_sf()


#we can compare it to the Albers projection
CA_Counties_Tigris_Albers_CA<-st_transform(CA_Counties_Tigris, crs=3310)

#looks different (how?)
ggplot(data=CA_Counties_Tigris_Albers_CA) +
  geom_sf()

#Class Exercise
#Create a data frame of Riverside county using the Mercator projection
#Create a data frame of Riverside county using the Albers projection



#Measure Area
st_area(Riverside_County_Mercator)
st_area(Riverside_County_Albers)

#Measure Area in square miles using the units package
set_units(st_area(Riverside_County_Albers), mi^2)



#select CSU's from the college locations data
CSU_data <-college_data %>%
  filter(F1SYSNAM == "California State University")

# Convert CSU_data to a sf object 
CSU_sf <- st_as_sf(CSU_data, coords = c("LONGITUD", "LATITUDE"), crs = 4269)

#select San Bernadino
CSUSB<-CSU_sf%>%
  filter(IALIAS=="Cal State San Bernardino")

#transform to the Albers projection
CSUSB_Albers<-st_transform(CSUSB, crs=3310)
UCR_Albers<-st_transform(UCR, crs=3310)

#calculate distance
st_distance(UCR_Albers,CSUSB_Albers)

#use the units package to report the distance in miles
set_units(st_distance(UCR_Albers,CSUSB_Albers), mi)

#let's compute distances between all the UC's and CSU's (prints to the console)

#first use Albers projection
UC_Albers<-st_transform(UC_sf, crs=3310)
CSU_Albers<-st_transform(CSU_sf, crs=3310)

#then calculate distance
st_distance(UC_Albers, CSU_Albers)

#let's save the distances as a matrix
distance_matrix<-set_units( st_distance(UC_Albers, CSU_Albers),mi)

#clean up the labeling
rownames(distance_matrix)=c(UC_sf$INSTNM)
colnames(distance_matrix)=c(CSU_sf$INSTNM)

#convert to a data frame
distance_data<-data.frame(distance_matrix)

#tidy it up

distance_reshape<-distance_data%>%
  rownames_to_column(var="UC campus")%>%
  pivot_longer(col=-("UC campus"),  
               names_to = "CSU campus", 
               values_to = "Distance")


#Class Exercise
#What's the average distance of UCR to all of the CSU campuses?



#If we want to measure the distance between the UC's and counties, we have to calculate the county centroids
CA_Counties_Centroids<-st_centroid(CA_Counties_Tigris_Albers_CA)

#Class Exercise


