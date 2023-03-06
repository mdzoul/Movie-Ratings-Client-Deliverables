#Import Data
setwd("/Users/zoulaimi/RProjects/Movie Ratings/Data")
mov <- read.csv("Section6-Homework-Data.csv")

#Data Exploration
head(mov)
tail(mov)
summary(mov)
str(mov)

#Activate ggplot2
library(ggplot2)

#Filter
Genre.Filtered <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")
Studio.Filtered <- mov$Studio %in% c("Buena Vista Studios", "WB", "Fox", "Universal", "Sony", "Paramount Pictures")

mov2 <- mov[Genre.Filtered & Studio.Filtered, ]
mov2

#Plotting Data
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))

#Add Geometry, Non-data Ink, Theme
q <- p + 
    geom_jitter(aes(size=Budget...mill., colour=Studio)) + 
    geom_boxplot(alpha=0.5)

r <- q +
    xlab("Genre") + ylab("Gross % US") +
    ggtitle("Domestic Gross % By Genre") +
    theme(axis.title.x=element_text(colour="blue", size=20),
          axis.title.y=element_text(colour="blue", size=20),
          
          axis.text.x=element_text(size=10),
          axis.text.y=element_text(size=10),
          
          legend.title=element_text(size=13),
          legend.text=element_text(size=10),
          
          plot.title=element_text(size=25,
                                  hjust=0.5),
          
          text=element_text(family="Comic Sans MS"))

#Final Touches
r$labels$size <- "Budget $M"
r
