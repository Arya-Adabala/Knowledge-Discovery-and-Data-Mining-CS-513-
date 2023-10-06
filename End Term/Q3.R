# Loading necessary libraries
library(rpart)
library(dplyr)

# Loading the dataset
absenteeism <- read.csv("C:/absenteeism_1.csv")

# Removing rows with missing values
absenteeism <- na.omit(absenteeism)

# Converting categorical variables to factors
absenteeism$Trans_expense_cat <- as.factor(absenteeism$Trans_expense_cat)
absenteeism$Dist_to_work <- as.factor(absenteeism$Dist_to_work)
absenteeism$Age_cat <- as.factor(absenteeism$Age_cat)
absenteeism$Abs_cat <- as.factor(absenteeism$Abs_cat)

# Spliting the dataset into training and testing sets (70% and 30%)
set.seed(42)
train_idx <- sample(1:nrow(absenteeism), 0.7 * nrow(absenteeism))
train_data <- absenteeism[train_idx, ]
test_data <- absenteeism[-train_idx, ]

# Training the CART classifier on the training set
cart_model <- rpart(Abs_cat ~ ., data = train_data, method = "class")

# Applying the classifier on the test set
predictions <- predict(cart_model, test_data, type = "class")

# Evaluating the classifier on the test set
accuracy <- sum(predictions == test_data$Abs_cat) / length(predictions)
cat("Accuracy:", accuracy, "\n")

# Calculating precision for Abs_cat=Abs_High
confusion_matrix <- table(predictions, test_data$Abs_cat)
precision <- confusion_matrix["Abs_High", "Abs_High"] / sum(confusion_matrix["Abs_High", ])
cat("Precision for Abs_cat=Abs_High:", precision, "\n")
