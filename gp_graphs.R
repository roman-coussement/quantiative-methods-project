library(tidyverse)
library(stargazer)
library(readxl)
library(clubSandwich)
library(ggplot2)
library(ggthemes)
library(reprex)
library(dplyr)
library(maps)
library(mapdata)
library(usmap)
library(ggpubr)

#Set working directory

setwd("C:/Users/rocou/Documents/University/Year 2/Semester 2/Quantitative Methods/Group Project")

#Load data

project_data <- read_xlsx("project_data.xlsx", na=".")

#Create variables for the following:

#1. Population Density
#2. Fatalities per 100,000
#3. Lane density
#4. Licensed drivers per 100,000
#5. Suicides per 100,000
#6. Hospitals per 100,000

project_data <- project_data %>% 
  mutate(population_density = population/land_area) %>%
  mutate(ft_traffic_per100k = (ft_traffic_total/population)*100000) %>%
  mutate(lane_density = lane_miles/population) %>%
  mutate(lic_drivers_per100k = (licensed_drivers/population)*100000) %>%
  mutate(suicide_per100k = (ft_suicide_21_34/population)*100000) %>%
  mutate(hospitals_per100k = (total_number_hospitals/population)*100000)

#some graphical representations

#graph showing the relationship between population density and traffic fatalities
#excluding d.c. as an outlier in terms of pop. density

scatterplot1 <- ggplot(subset(project_data, project_data$fips != "11" )) +
  geom_jitter(aes(population_density, ft_traffic_per100k))+
  geom_smooth(aes(population_density, ft_traffic_per100k), method = lm)+
  xlab("Population Density")+
  ylab("Number of traffic fatalities 
       per 100,000")+
  theme_tufte()
scatterplot1

#graph showing the relationship between population density and suicide rate
#excluding d.c. as an outlier in terms of pop. density

scatterplot2 <- ggplot(subset(project_data, project_data$fips != "11" )) +
  geom_jitter(aes(population_density, suicide_per100k))+
  geom_smooth(aes(population_density, suicide_per100k))+
  xlab("Population Density")+
  ylab("Number of suicides per 100,000")+
  theme_tufte()
scatterplot2

#graph showing the relationship between licensed drivers and traffic fatalities

scatterplot3 <- ggplot(project_data, aes(lic_drivers_per100k, ft_traffic_per100k))+
  geom_point()+
  xlab("Licensed Drivers (p/100,000)")+
  ylab("Number of traffic fatalities 
       (p/100,000)")+
  theme_tufte()
scatterplot3

#graph showing the relationship between lane density and traffic fatality rate

scatterplot4 <- ggplot(project_data, aes(lane_density, ft_traffic_per100k))+
  geom_point()+
  geom_smooth()+
  xlab("Number of lane miles per square mile")+
  ylab("Number of traffic fatalities (p/100,000)")+
  theme_tufte()
scatterplot4

#graph showing the relationship between median income and suicide rate

scatterplot5 <- ggplot(project_data, aes(median_income, suicide_per100k))+
  geom_point()+
  xlab("Median Income")+
  ylab("Suicide Rate")+
  theme_tufte()
scatterplot5

#graph showing the relationship between unemployment rate and suicide rate

scatterplot6 <- ggplot(project_data, aes(unemployment_rate, suicide_per100k))+
  geom_point()+
  geom_smooth()+
  xlab("Unemployment Rate")+
  ylab("Suicide Rate")+
  theme_tufte()
scatterplot6

#graph showing the relationship between hospitals per 100,000 and traffic fatality rate

scatterplot7 <- ggplot(project_data, aes(hospitals_per100k, ft_traffic_per100k))+
  geom_point()+
  geom_smooth(method = lm)+
  xlab("Number of hospitals per 100,000")+
  ylab("Traffic fatality rate")+
  theme_tufte()
scatterplot7

#maps showing traffic fatality rate by state over time

map1 <- plot_usmap(region="state", data = project_data, values = "ft_traffic_per100k",
           colour = "black") +
  scale_fill_continuous(low = "white", high = "mediumpurple4", name = "Fatality Rate")+
  labs(title = "Traffic fatality rate by region",
       subtitle = "Number of fatalities per 100,000 of the population for each
       U.S. state and the District of Columbia")+
  facet_wrap(~year)+
  theme_tufte()+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
map1

#maps showing suicide rate by state over time

map2 <- plot_usmap(region="state", data = project_data, values = "suicide_per100k",
                  colour = "black") +
  scale_fill_continuous(low = "white", high = "mediumpurple4", name = "Suicide Rate")+
  labs(title = "Suicide rate by region",
       subtitle = "Number of suicides per 100,000 of the population for each
       U.S. state and the District of Columbia")+
  facet_wrap(~year)+
  theme_tufte()+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
map2

#an arrangement of the scatterplots into two grids in their groups
#as they relate to a given dependent variable

ggarrange(scatterplot1, scatterplot3, scatterplot4, scatterplot7, widths = c(2,2,2,2))
ggarrange(scatterplot2, scatterplot5, scatterplot6)


          