library(tidyverse)
library(ggthemes)
library(readxl)
library(janitor)
library(ggplot2)
library(dplyr)
library(tidyr)
library(gganimate)
library(lubridate)
library(gifski)
library(ggimage)

#Data 
data<-read_excel("agent_pickrates.xlsx",sheet="Sheet1") 



#Code for Bar Plot
plot<-data |> 
  ggplot(mapping=aes(x=Agent,y=Pick_Rate,color=Agent,fill=Agent))+ 
  geom_col()+  
  theme_clean()+
  theme(legend.position = "none",
        axis.title = element_text(face="bold",size=13),
        plot.title = element_text(face="bold",size=20))+
  scale_y_continuous(labels = scales::percent)+
  scale_x_discrete(guide = guide_axis(n.dodge=2))+
  labs(title="Pick Rates of Valorant Agents by Season",
       subtitle="Episode: {frame_time}",
       y="Pick Rate (%)",
       caption="Source: blitz.gg")


#Transition for Bar Plot
final_plot<- plot + transition_time(Date)

val_plot<-animate(final_plot, 
        duration = 30,
        fps  =  10)

save_gif(val_plot)
