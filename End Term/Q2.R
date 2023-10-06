# Loading required libraries
library(randomForest)
library(dplyr)

# Reading the data
mydata <- read.csv("C:/absenteeism_1.csv")

# Removing missing values
mydata <- na.omit(mydata)

# Converting categorical variables to factors
mydata$Trans_expense_cat <- as.factor(mydata$Trans_expense_cat)
mydata$Dist_to_work <- as.factor(mydata$Dist_to_work)
mydata$Age_cat <- as.factor(mydata$Age_cat)
mydata$Abs_cat <- as.factor(mydata$Abs_cat)

# Spliting data into training and testing sets (70% and 30%)
set.seed(42)
train_index <- sample(1:nrow(mydata), 0.7 * nrow(mydata))
train_data <- mydata[train_index, ]
test_data <- mydata[-train_index, ]

# Training the Random Forest classifier on the training set with 500 trees
rf_model <- randomForest(Abs_cat ~ ., data = train_data, ntree = 500)

# Applying the classifier on the test set
rf_predictions <- predict(rf_model, test_data)

# Evaluating the classifier on the test set
accuracy <- sum(rf_predictions == test_data$Abs_cat) / length(rf_predictions)
cat("Accuracy:", accuracy, "\n")

# Calculating precision for Abs_cat=Abs_High
conf_matrix <- table(rf_predictions, test_data$Abs_cat)
precision <- conf_matrix["Abs_High", "Abs_High"] / sum(conf_matrix["Abs_High", ])
cat("Precision for Abs_cat=Abs_High:", precision, "\n")
