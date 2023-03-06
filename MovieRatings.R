#---------- Data ----------#
getwd()
setwd("/Users/zoulaimi/RProjects/Movie Ratings")
getwd()

movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

movies$Year <- factor(movies$Year) #changing Genre & Year from numeric variable into a factor
movies$Genre <- factor(movies$Genre)
summary(movies)
str(movies)

#---------- Aesthetics ----------#
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#Add Geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#Add Colour
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        colour=Genre)) + 
  geom_point()

#Add Size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        colour=Genre, size=Genre)) + 
  geom_point()

#Add Size - Better Way
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        colour=Genre, size=BudgetMillions)) + 
  geom_point()
#>>>This is chart1 (we will improve it)

#---------- Plotting With Layers ----------#
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             colour=Genre, size=BudgetMillions)) #this is actually an object

#Point
p + geom_point()

#Lines
p + geom_line()

#Multiple Layers
p + geom_point() + geom_line()
p + geom_line() + geom_point()

#---------- Overriding Aesthetics ----------#
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre, size=BudgetMillions))

#Add Geom Layer
q + geom_point()

#Overriding Aesthetics
q + geom_point(aes(size=CriticRating)) #eg1
q + geom_point(aes(size=BudgetMillions)) #eg2
q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions $$$") #eg3 >>> This is chart2
q + geom_line(size=1) + geom_point() #eg4 intro to mapping vs setting

#---------- Mapping VS Setting ----------#
r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#Add Colour
#1. Mapping (what we've done so far)
r + geom_point(aes(colour=Genre))
#2. Setting
r + geom_point(colour="DarkGreen")
#ERROR:
#r + geom_point(aes(colour="DarkGreen"))

#Change Size
#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#2. Setting
r + geom_point(size=5)
#ERROR:
#r + geom_point(aes(size=5))

#---------- Histograms and Density Charts ----------#
s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth=10)

#Add Colour
s + geom_histogram(binwidth=10, aes(fill=Genre))

#Add Border
s + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")
#>>> This is chart3 (we will improve it)

#Density Charts (may need them sometimes)
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

#---------- Starting Layer Tips ----------#
t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, 
                   fill="White", colour="Blue")

#Another way to achieve the same chart
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, 
                   aes(x=AudienceRating),
                   fill="White", colour="Blue")
#>>> This is chart4

t + geom_histogram(binwidth = 10, 
                   aes(x=CriticRating),
                   fill="White", colour="Blue")
#>>> This is chart5

#Skeleton Plot
#t <- ggplot()

#---------- Statistical Transformations ----------#
?geom_smooth

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))
u + geom_point() + geom_smooth(fill=NA)

#Boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating, colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot() + geom_point(size=0.5)
#Tip/Hack (for better visualisation using boxplots):
u + geom_boxplot() + geom_jitter(size=0.5)
#Another way (better style)
u + geom_jitter(size=0.5) + geom_boxplot(alpha=0.5)
#>>> This is chart6

#---------- Using Facets ----------#
v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth=10, aes(fill=Genre), colour="black")

#Facets
v + geom_histogram(binwidth=10, aes(fill=Genre), colour="black") +
    facet_grid(Genre~., scales="free")

#Scatterplots
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))
w + geom_point(size=1)
#Facets
w + geom_point(size=1) + facet_grid(Genre~.)
w + geom_point(size=1) + facet_grid(.~Year)
w + geom_point(size=1) + facet_grid(Genre~Year) + geom_smooth(fill=NA)
w + geom_point(size=1) + facet_grid(Genre~Year) + geom_smooth(fill=NA)
w + geom_point(aes(size=BudgetMillions)) + facet_grid(Genre~Year) + geom_smooth()
#>>> This is chart1 (but still will improve)

#---------- Using Facets ----------#
m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             size=BudgetMillions, colour=Genre))
m + geom_point()
m + geom_point() + xlim(50, 100) + ylim(50, 100)
#Won't work well always

n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth=10, aes(fill=Genre), colour="black")
n + geom_histogram(binwidth=10, aes(fill=Genre), colour="black") +
    ylim(0, 50)

#Instead - Zoom
n + geom_histogram(binwidth=10, aes(fill=Genre), colour="black") +
    coord_cartesian(ylim=c(0, 50))

#Improve Chart1
w + geom_point(aes(size=BudgetMillions)) + facet_grid(Genre~Year) + geom_smooth() +
    coord_cartesian(ylim=c(0, 100))

#---------- Theme ----------#
o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre), colour="Black")

h

#Axes Label
h + 
    xlab("Money Axis") + ylab("Number of Movies")

#Label Formatting
h + 
    xlab("Money Axis") + ylab("Number of Movies") +
    
    theme(axis.title.x=element_text(colour="darkgreen", size=30),
          axis.title.y=element_text(colour="red", size=30))

#Tick Mark Formatting
h + 
    xlab("Money Axis") + ylab("Number of Movies") +
    
    theme(axis.title.x=element_text(colour="darkgreen", size=30),
          axis.title.y=element_text(colour="red", size=30),
          
          axis.text.x=element_text(size=20),
          axis.text.y=element_text(size=20))

?theme

#Legend Formatting
h + 
    xlab("Money Axis") + ylab("Number of Movies") +
    
    theme(axis.title.x=element_text(colour="darkgreen", size=30),
          axis.title.y=element_text(colour="red", size=30), 
          
          axis.text.x=element_text(size=20),
          axis.text.y=element_text(size=20),
          
          legend.title=element_text(size=30),
          legend.text=element_text(size=20),
          legend.position=c(1,1), 
          legend.justification=c(1,1))

#Title Of Plot
h + 
    xlab("Money Axis") + ylab("Number of Movies") +
    
    ggtitle("Movie Budget Distribution") +
    
    theme(axis.title.x=element_text(colour="darkgreen", size=20),
          axis.title.y=element_text(colour="red", size=20), 
          
          axis.text.x=element_text(size=10),
          axis.text.y=element_text(size=10),
          
          legend.title=element_text(size=20),
          legend.text=element_text(size=10),
          legend.position=c(1,1), 
          legend.justification=c(1,1),
          
          plot.title=element_text(colour="darkblue", 
                                  size=25,
                                  family="Courier",
                                  hjust=0.5)) 
#>>> This is chart3