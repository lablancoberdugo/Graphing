## Genome size plot
#this loads the package
library(ggplot2)
library(RColorBrewer)

#before starting you have to set your working directory 
setwd("Work/ElephantShark/Graphs/")
#read the file
x = read.csv("LBBData.csv")
x = x[,c(1,3,4,5,7)]
#change the column names
colnames(x) = c("Organism","GenomeSize","PercTE","RelativeTE","Class")
head(x)
#dot plot
ggplot(x, aes(x = GenomeSize, y = PercTE, color = Class)) +
  geom_point() +
  geom_text(aes(label=Organism),hjust=0, vjust=0, color = "black") +
  geom_smooth(method = "lm", color = "black", size = 0.5, alpha = 0.15) +
  scale_color_manual(values = c("red","blue","green","yellow","purple")) +
  scale_x_continuous(breaks =seq(0,3600,600)) +
  scale_y_continuous(breaks = seq(0,60,10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 0, hjust = 1),
        axis.text = element_text(size=12),
        axis.title.x = element_text(vjust=-0.1),
        axis.title.y = element_text(vjust=+1.1),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank()) +
  theme(axis.line = element_line(color = 'black')) +
  theme(legend.position = "bottom") +
  ylab("% TE") +
  xlab("Genome Size")
