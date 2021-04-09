library(tidyverse)

diss_time <- read_csv("./Data/Dissertimeline_2021-04-08.csv")

# Order factor levels
diss_time$Activity <- factor(diss_time$Activity, 
                             levels = c("Committee_Reads", 
                                        "Committee_Comments", 
                                        "Fix_Issues",
                                        "Defense_Date",
                                        "Done"))

diss_time$Project_element <- factor(diss_time$Project_element, 
                             levels = c("First_draft", 
                                        "Address_Comments", 
                                        "Defense", 
                                        "Submission"))

plot_gantt <- qplot(ymin = Start,
                    ymax = End,
                    x = factor(Project_element, 
                               levels = rev(levels(factor(Project_element)))),
                    colour = Activity,
                    geom = "linerange",
                    data = diss_time,
                    size = I(5)) +
  scale_x_discrete(labels=c("First_draft" = "First Draft", 
                            "Address_Comments" = "Address Comments",
                            "Defense" = "Defense",
                            "Submission" = "Submission")) +
  scale_y_date(date_labels = "%b-%d",
               breaks = as.Date(c("2021-05-17",
                                  "2021-06-07",
                                  "2021-06-25",
                                  "2021-07-16",
                                  "2021-08-01"))) +
  scale_colour_manual(values = c("grey", "blue", 
                                 "green", "black", 
                                 "red"),
                      labels = c("Commitee Reads", 
                                 "Commitee Comments", 
                                 "Jerred Addresses Issues",
                                 "Defense Date Set",
                                 "Done")) +
  coord_flip() +
  theme(panel.grid = element_blank()) +
  xlab("") +
  ylab("Date") +
  ggtitle("DisserTimeline") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme_classic(base_size = 20, 
                base_family = "")

plot_gantt 

