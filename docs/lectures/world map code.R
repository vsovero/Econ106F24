library(rnaturalearth)
library(rnaturalearthdata)
library(tidyverse)

europe<-ne_countries(continent = "Europe", scale = "medium")

ggplot(data=europe)+
  geom_sf()+
coord_sf(xlim = c(-20, 50), ylim = c(33, 80)) 

world<-ne_countries()

ggplot(data=world)+
  geom_sf()

