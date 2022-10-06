#install package
#install.packages("tidyverse")

library(tidyverse)

# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
dataurlFL ="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00012839_14_0_1/station.txt"

read_table(dataurl)

read_table(dataurlFL)

#the next line tells the NASA site to create the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")

httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00012839&dt=1&ds=14")


# the next lines download the data
temp=read_table(dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))

tempFL=read_table(dataurlFL,
                  skip=3, #skip the first line which has column names
                  na="999.90", # tell R that 999.90 means missing in this dataset
                  col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                                "APR","MAY","JUN","JUL",  
                                "AUG","SEP","OCT","NOV",  
                                "DEC","DJF","MAM","JJA",  
                                "SON","metANN"))

temp_Allstations <- bind_rows('Buffalo, NY' = temp,
                              "Miami, FL" = tempFL, 
                              .id= "station")

Summary (temp_Allstations)
# renaming is necessary becuase they used dashes ("-")
# in the column names and R doesn't like that.

#View(temp)

#summary(temp) 

#glimpse(temp)

#install.packages("ggplot2")
library(ggplot2)

ggplot(temp) + 
  geom_smooth(mapping = aes(x = YEAR, y = JJA), color="red") +
  geom_line(mapping = aes(x = YEAR, y = JJA)) +
  xlab("YEAR") + ylab("Annual Mean Temperatures (C)") +
  ggtitle("Mean Summer tempurature in Buffalo, NY", 
          subtitle = "Summer includes June, July and August \nData from the Global Historical Newtork \nRed line is LOESS Smooth") 

ggplot(tempFL) + 
  geom_smooth(mapping = aes(x = YEAR, y = JJA), color="red") +
  geom_line(mapping = aes(x = YEAR, y = JJA)) +
  xlab("YEAR") + ylab("Annual Mean Temperatures (C)") +
  ggtitle("Mean Summer tempurature in Buffalo, NY", 
          subtitle = "Summer includes June, July and August \nData from the Global Historical Newtork \nRed line is LOESS Smooth") 

ggsave(file="Mean Summer tempurature in Buffalo2.png")

