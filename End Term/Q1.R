# Loading necessary libraries
library(C50)
library(dplyr)

# Loading the dataset
absenteeism_data <- read.csv("C:/absenteeism_1.csv")

# Removing rows with missing values
absenteeism_data <- na.omit(absenteeism_data)

# Converting the 'Abs_cat' column to a factor
absenteeism_data$Abs_cat <- as.factor(absenteeism_data$Abs_cat)

# Spliting the dataset into training and testing sets (70% and 30%)
set.seed(42)
train_index <- sample(1:nrow(absenteeism_data), 0.7 * nrow(absenteeism_data))
train_data <- absenteeism_data[train_index, ]
test_data <- absenteeism_data[-train_index, ]

# Training the C5.0 classifier on the training set
absenteeism_model <- C5.0(Abs_cat ~ ., data = train_data)

# Applying the classifier on the test set
absenteeism_predictions <- predict(absenteeism_model, test_data)

# Evaluating the classifier on the test set
absenteeism_accuracy <- sum(absenteeism_predictions == test_data$Abs_cat) / length(absenteeism_predictions)
cat("Accuracy:", absenteeism_accuracy, "\n")

# Calculating precision for Abs_cat=Abs_High
absenteeism_confusion_matrix <- table(absenteeism_predictions, test_data$Abs_cat)
absenteeism_precision <- absenteeism_confusion_matrix["Abs_High", "Abs_High"] / sum(absenteeism_confusion_matrix["Abs_High", ])
cat("Precision for Abs_cat=Abs_High:", absenteeism_precision, "\n")
