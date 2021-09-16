#Install and load any packages

library(tidyverse)
library(stargazer)
library(readxl)
library(clubSandwich)
library(ggplot2)
library(ggthemes)
library(reprex)
library(dplyr)

#Set working directory

setwd("C:/Users/rocou/Documents/University/Year 2/Semester 2/Quantitative Methods/Group Project")

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
  mutate(ft_traffic_21_34_per100k = (ft_traffic_21_34/population)*100000) %>%
  mutate(lane_density = lane_miles/population) %>%
  mutate(lic_drivers_per100k = (licensed_drivers/population)*100000) %>%
  mutate(suicide_per100k = (ft_suicide_21_34/population)*100000) %>%
  mutate(hospitals_per100k = (total_number_hospitals/population)*100000)

#use mutate function to create factor variables for state and year

project_data <- project_data %>% 
  mutate(year_fct = factor(year),
         fips_fct = factor(fips))

#mod1, mod2, mod3 denote the 3 models for the first regression analysis, as
#detailed in the methodology

mod1<- lm(ft_traffic_per100k ~ legal, data = project_data)

mod2 <- lm(ft_traffic_per100k ~ legal + fips_fct + year_fct + fips_fct:year, data = project_data)

mod3 <- lm(ft_traffic_per100k ~ legal + fips_fct + year_fct + fips_fct:year +
             lane_density + population_density + lic_drivers_per100k + hospitals_per100k,
           data = project_data)

#mod4, mod5, mod6 denote the 3 models for the second regression analysis

mod4 <- lm(suicide_per100k ~ legal, data = project_data)

mod5 <- lm(suicide_per100k ~ legal + fips_fct + year_fct + fips_fct:year, data = project_data)

mod6 <- lm(suicide_per100k ~ legal + fips_fct + year_fct + fips_fct:year +
             median_income + unemployment_rate + population_density, data = project_data)

#creates stargazer tables for regression output

stargazer(mod1, mod2, mod3, keep = "legal", type="text") # keep = "legal" only reports legal

stargazer(mod4, mod5, mod6, keep = "legal", type="text")


plot(suicide_per100k ~ legal, data = project_data, xlab = "Legal", ylab = "Suicide rate")
abline(mod1, xlab = "Legal", ylab = "Traffic fatality rate")

plot(suicide_per100k ~ legal, data = project_data, xlab = "Legal", ylab = "Suicide rate")
abline(mod4, xlab = "Legal", ylab = "Suicide rate")

