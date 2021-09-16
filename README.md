# Quantitative Methods Project

### Introduction
This repository contains the collected work of a group econometrics project, undertaken as part of my undergraduate degree. For the project, we were tasked with formulating a research question relating to the possible causal effect of a policy intervention, collecting the relevent data, and producing a statistical inference model (in this case an OLS regression model) in an attempt to answer the question of whether a causal effect exists.
<br/>
<br/>
The sum of our work was then be collated in a write-up containing an abstract, methodology, data summary, literature review, results, and conclusion; the kind of structure you might expect of any quantitative research paper.

### Summary

For our project, we chose to look at the relationship between the legalisation of cannabis for recreational use and both traffic- and suicide-related fatalities. In particular, the subject of the study was the fifty US states plus Washington D.C., of which eight plus Washington D.C. have legalised cannabis for recreational use. 
<br/>
Our results showed a relationship between the independent variable and the two variables in question, however the effect was not statistically significant.

### Data

The data for the project was collated from multiple sources, with the key variables as follows:

* Traffic fatality rate – this refers to a population-adjusted figure taken from the number of traffic-related fatalities in each state for the given time period. Analysis has been carried out on both the total population, and a subset between the ages of 21 and 34, to reflect the unequal distribution of cannabis users between age groups.
* Suicide rate – this is a population-adjusted figure based on the number of suicides recorded among those between the ages of 21 and 34, again reflecting the distribution of cannabis use.
* Population density
* Licensed drivers per 100,000 of the population
* Lane density (miles of road lane per square mile)
* Population density
* Median income
* Unemployment rate

### Methodology

Our methodology can be summarised as a multi-state, multi-period, difference-in-difference (DiD) model. To reflect the staggered rollout of the policy, we rely on the creation of the ‘legal’ variable, so as to incorporate all groups into a single model; this reflects varying intensity of the treatment over time, taking a value between zero and one, a group not exposed to the policy whatsoever being attributed zero, and a group fully exposed to the policy being given a value of one. As our data is recorded annually, it has sometimes been necessary to attribute a value between zero and one, reflecting the fact that the policy may only have been brought into effect partway through the year, with the policy varying in intensity in a given year as a result. 
<br/>
<br/>
Our first model is a simple regression of the dependent variable against the legal variable, with the regression coefficient as our output. In the second model we include variables to represent state-fixed effects and time-fixed effects in order to control for any variation between states and across time that aren’t related to the policy, and a variable to control for state-specific time-trends. In the final model, we include multiple different control variables that we believe to be correlated with the dependent variable in question. Thus, we defined the models as follows:

$$Y=\beta_{0}+\beta_{1}LEGAL+e $$
$$Y=\beta_{0}+\beta_{1}LEGAL+\beta_{2}STATE+\beta_{3}YEAR+\beta_{4}STATE:YEAR+e $$
$$Y=\beta_{0}+\beta_{1}LEGAL+\beta_{2}STATE+\beta_{3}YEAR+\beta_{4}STATE:YEAR+\beta_{5}CONTROL_{1}+...+\beta_{n}CONTROL_{n}+e $$
