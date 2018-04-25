#Histogram for the Austrian ghost shark TE landscape
#this script contain several commands that I used to make
#the histogram for TE insertion patterns

#this instals the graphing package, this is in case you dont have it already installed
#install.packages("ggplot2")

#this loads the package
library(ggplot2)
library(RColorBrewer)

#before starting you have to set your working directory 
setwd("Work/ElephantShark/Graphs/")

#after setting the directory then you read the file that contains the TE data
stackedbarplot = read.csv("stackplot.csv", header = F)
head(stackedbarplot)

#created sequence from 0-35 skips 0.5
time = seq(0,18, 0.5)
#file $ pick or create a new column
stackedbarplot$time = time

#head
head(stackedbarplot)

#change the column name
colnames(stackedbarplot) = c("bin","PercGenome","Group","Time") #nospaces!

#load the graphic package
library(ggplot2)

#plotting command

ggplot(stackedbarplot, #this gives file name
       aes(x = Time, y = PercGenome, fill = Group)) +
  geom_bar(stat = "identity") + #barplot this changes for types of plot
  scale_fill_manual(values = c("red","yellow","lightsteelblue2","blue", #colors that we want
                               "blueviolet","aliceblue","orange","maroon1",
                               "darkgrey","olivedrab1", "mediumspringgreen", "black", "pink", "purple", "white")) +
  scale_x_continuous(breaks =seq(0,36,1), limits = c(0,18)) + #changes the breaks of the scale
  scale_y_continuous(breaks = seq(0,0.02,0.002)) +
  theme_bw() + #blackground
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.text = element_text(size=12),
        axis.title.x = element_text(vjust=-0.1),
        axis.title.y = element_text(vjust=+1.1),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank()) +
  theme(axis.line = element_line(color = 'black')) + #axis line
  ylab("Percent Genome") + #change label of the axis to what we want 
  xlab("Time (mya)")

