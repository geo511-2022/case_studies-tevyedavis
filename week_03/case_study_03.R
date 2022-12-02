#install.packages("gapminder")
library(gapminder)

library(ggplot2)

library(dplyr)

#View(gapminder)

#remove "Kuwait" from the gapminder
gapminder2<- gapminder %>% filter(!(country %in% "Kuwait"))

#View(gapminder2)

#Plot #1 

plot1<- ggplot(gapminder2, aes(lifeExp, gdpPercap, color = continent, size=pop/100000)) +
  geom_point() +
  theme_bw() +
  scale_y_continuous(trans = "sqrt") +
  facet_wrap(~year,nrow=1) +
  labs(x= "Life Expectancy", y= "GDP per Capita")

plot1

ggsave("plot1.png", width = 15, units= "in")   

#Prepare the data for the second plot
gapminder_continent <- gapminder2 %>% group_by(continent, year) %>% 
  summarise(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))

#View(gapminder_continent)  

#Plot #2 (the second row of plots)


plot2<- ggplot(gapminder2, aes(year, gdpPercap)) +
  geom_line(aes(color=continent, group = country)) + 
  geom_point(aes(color = continent, group = country)) +
  geom_line(data=gapminder_continent, aes(y = gdpPercapweighted)) +
  geom_point(data=gapminder_continent, aes(y = gdpPercapweighted, size =pop/100000)) +
  facet_wrap(vars(continent)) +
  theme_bw() +
  labs(x = "Year", y = "GDP per Capita", size = "Population (100k)", color = "Continent")

plot2

ggsave("plot2.png", width = 15, units= "in")   