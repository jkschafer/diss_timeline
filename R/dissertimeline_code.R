library(ggplot2)
library(readr)
library(tidyverse)

diss_time <- read.csv("Dissertimeline_2021-04-05.csv")
diss_time <- as_tibble(diss_time)

level_order <- c('First_draft', 'Address_Comments', 
                 'Defense_Date', 'Submission')
# Order Activity levels
diss_time$Activity <- factor(diss_time$Activity, 
                             levels = c("Committee_Reads", 
                                        "Committee_Comments", 
                                        "Fix_Issues", 
                                        "Hopefully_Done",
                                        "Zoom_Defense",
                                        "Done"))

diss_time$Project_element <- factor(diss_time$Project_element, 
                             levels = c("First_draft", 
                                        "Address_Comments", 
                                        "Defense_Date", 
                                        "Submission"))


plot_gantt <- qplot(ymin = Start,
                    ymax = End,
                    x = factor(Project_element, 
                               levels = rev(levels(factor(Project_element)))),
                    colour = Activity,
                    geom = "linerange",
                    data = diss_time,
                    size = I(5)) +
  scale_colour_manual(values = c("grey", "blue", 
                                 "green", "black", 
                                 "red", "purple")) +
  coord_flip() +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  xlab("") +
  ylab("Date") +
  ggtitle("DisserTimeline") +
  theme(plot.title = element_text(hjust = 0.5))

plot_gantt

