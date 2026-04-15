#Import the Data
getwd()
setwd("C:/Users/Infz/Desktop")
mov <- read.csv("Data.csv")

#Data Exploration
head(mov) #top rows
summary(mov) #column summaries
str(mov) #structure of the dataset

#Activate GGPlot2
#install.packages("ggplot2")
library("ggplot2")

#{Offtopic} This Is A Cool Insight:
ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()
#Notice? No movies are released on a Monday. Ever.

#Now we need to filter our dataset to leave onlly the 
#Genres and Studios that we are interested in
#We will start with the Genre filter and use the Logical 'OR'
#operator to select multiple Genres:
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Now let's do the same for the Studio filter:
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio == "WB") | (mov$Studio == "Fox") | (mov$Studio == "Universal") | (mov$Studio == "Sony") | (mov$Studio == "Paramount Pictures")
  
#Apply the row filters to the dataframe
mov2 <- mov[filt & filt2,]
mov2

#Prepare the plot's data and aes layers
#Note we did not rename the columns. 
#Use str() or summary() to fin out the correct column names
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p #Nothing happens. We need a geom.

#Add a Point Geom Layer
q<- p + 
  geom_jitter(aes(size=Budget...mill., colour=Studio)) +
  geom_boxplot(alpha=0.7 , outlier.colour=NA)

q

#Non-data ink
q <- q +
  xlab("Genre") + #x axis title
  ylab("Gross % US") + #y axis title
  ggtitle("Domestic Gross By Genre") #plot title
q

#HINT: for the next part use ?theme if you need to 
#refresh which parameters are responsible for what

#Theme
q <- q + 
  theme(
    #Axes titles:
    axis.title.x = element_text(colour="Blue", size=30),
    axis.title.y = element_text(colour="Blue", size=30),
    
    #Axes texts:
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),  
    
    #Plot title:
    plot.title = element_text(colour="Black",
                              size=40),
    
    #Legend title:
    legend.title = element_text(size=20),
    
    #Legend text
    legend.text = element_text(size=12)
    
  )
q

#Final touch.
q$labels$size = "Budget $M"
q
