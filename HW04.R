# Clearing the workspace
rm(list=ls())

# Loading the dataset
file_path <- file.choose("C:/breast-cancer-wisconsin.csv")
bc_raw <- read.csv(file_path, na.strings = "?", colClasses=c("Sample"="character","F1"="factor","F2"="factor","F3"="factor","F4"="factor","F5"="factor","F6"="factor","F7"="factor","F8"="factor","F9"="factor","Class"="factor"))

# Checking if F1 is a factor variable
is_factor_var <- is.factor(bc_raw$F1)

# Removing any missing values from the dataset
bc <- na.omit(bc_raw)

# Spliting the data into training and test sets
idx <- sort(sample(nrow(bc), as.integer(.70 * nrow(bc))))
training <- bc[idx,]
test <- bc[-idx,]

# Loading the e1071 package for Naive Bayes classification
library(e1071)

# Fitting a Naive Bayes model to the training set using all variables
nBayes <- naiveBayes(factor(Class) ~ ., data = training[, -1])

# Using the Naive Bayes model to predict the class labels of the test set
category_all <- predict(nBayes, test[, -1])

# Displaying the results of the classification
table(NBayes = category_all, Survived = test$Class)
NB_wrong <- sum(category_all != test$Class)
NB_error_rate <- NB_wrong / length(category_all)
NB_error_rate

