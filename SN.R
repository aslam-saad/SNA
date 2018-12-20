
#packages
library(tidyverse)
library(igraph)


#read data
data <- read_csv("group network.csv")

#igraph reads the first two columns of a data frame to make a network
#gather all columns (leader1, leader2, leader3 into one column)
data <- data %>%
    gather(key = "Type", value = "Connection", -Interviewee) %>%
    select(Interviewee, Connection, everything())

#creat a graph form data
gg <- graph_from_data_frame(data)

#make the vertices shape spherical 
V(gg)$shape = "sphere"

#the color of nodes refer to interviewees as white, others are red.
V(gg)$color = "#EC7063" 
V(gg)[1:11]$color = "white"

#the color of the edges:
E(gg)[1:11]$color = "darkorange"   #highlight edges refer to 1st most influential in orange
E(gg)[12:22]$color = "dodgerblue1" #highlight edges refer to 2nd most influential in blue
E(gg)[23:33]$color = "grey"        #highlight edges refer to 3rd most influential in grey

#get rid of margins
par(mar=c(0, 0, 0, 0))

#plot the network
set.seed(202019992)
plot.igraph(gg, layout = layout.kamada.kawai, 
            vertex.size=10,
            vertex.frame.color="grey",
            vertex.label.family="Tahoma",
            vertex.label.fonty=4,
            vertex.label.color="black",
            vertex.label.cex=.8,
            edge.arrow.size=.4,
            edge.arrow.width=.9)

