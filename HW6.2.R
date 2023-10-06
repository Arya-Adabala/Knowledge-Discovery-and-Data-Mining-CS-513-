# Loading the necessary libraries
library(randomForest)

# Reading in the breast cancer data
bc_data <- read.csv("C:/breast-cancer-wisconsin.csv",
                    na.strings = "?",
                    colClasses = c("Sample" = "character",
                                   "F1" = "factor",
                                   "F2" = "factor",
                                   "F3" = "factor",
                                   "F4" = "factor",
                                   "F5" = "factor",
                                   "F6" = "character",
                                   "F7" = "factor",
                                   "F8" = "factor",
                                   "F9" = "factor",
                                   "Class" = "factor"))

# Checking the summary of the 6th feature column (F6) and filling any missing values with the mode
summary(bc_data$F6)
bc_data[is.na(bc_data$F6), "F6"] <- "M"

# Selecting columns and converting F6 to a factor
bc_df <- data.frame(bc_data[, 1:6], F6 = as.factor(bc_data$F6), bc_data[, 8:11])

# Spliting the data into training and test sets
index <- sort(sample(nrow(bc_df), round(0.3 * nrow(bc_df))))
train_data <- bc_df[-index, ]
test_data <- bc_df[index, ]

# Creating the random forest model with 1000 trees and calculating feature importance
rf_model <- randomForest(Class ~ ., data = train_data[-1], ntree = 1000)
importance <- importance(rf_model)
varImpPlot(rf_model)

# Making predictions on the test set and creating a confusion matrix
predictions <- predict(rf_model, test_data[-1])
confusion_matrix <- table(test_data$Class, predictions)

# Calculating the error rate
error_rate <- mean(test_data$Class != predictions)

