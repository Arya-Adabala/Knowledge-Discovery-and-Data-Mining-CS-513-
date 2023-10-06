#Clearing the workspace
rm(list=ls())

#Loading the dataset and reading the data
file <- file.choose()
bc <- read.csv(file, na.strings = "?", colClasses = c("Sample"="character", "F1"="factor", "F2"="factor",
                                                      "F3"="factor", "F4"="factor", "F5"="factor",
                                                      "F6"="factor", "F7"="factor", "F8"="factor",
                                                      "F9"="factor", "Class"="factor"))

#Loading the C50 package for classification
library('C50')

#Spliting the data into training and test sets
index <- sort(sample(nrow(bc), round(0.3 * nrow(bc))))
training <- bc[-index,]
test <- bc[index,]
