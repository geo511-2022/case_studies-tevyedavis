library(tidyverse)
library(nycflights13)



#The nycflights13 package provides the following data frames.

#flights : all flights that departed from NYC in 2013
#weather : hourly meterological data for each airport
#planes : construction information about each plane
#airports : airport names and locations
#airlines : translation between two letter carrier codes and names

view(flights) #dest #distance

#view(weather)

#view(planes)

view(airports)

#view(airlines)

ar<-arrange(flights, desc(distance))

#view(ar)

jn<-left_join(ar, airports,by=c("dest"="faa")) 

#view(jn)

final<-jn %>% select("dest", "name")

row1<-final[1,]

farthest_airports<-as.character(row1)

farthest_airports

