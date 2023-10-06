# Loading the dataset
data <- read.csv("Downloads/CS513_targeting_num.CSV")

# Removing missing values
data <- na.omit(data)

# Loading the required library
library(class)

# Define the predictors and response variable
predictors <- data[, c("Age", "Gender", "Income")]
response <- data$Purchase

# Creating the training and testing datasets
set.seed(123)
train_index <- sample(nrow(data), round(0.7*nrow(data)), replace = FALSE)
train_predictors <- predictors[train_index, ]
train_response <- response[train_index]
test_predictors <- predictors[-train_index, ]
test_response <- response[-train_index]

# Training the KNN model
knn_model <- knn(train_predictors, test_predictors, train_response, k = 3, prob = TRUE)

# Predicting the test set
knn_predictions <- knn_model$class

# Evaluate model performance
performance_table <- table(knn_predictions, test_response)

# Compute the classification metrics
tp <- sum(knn_predictions == "Yes" & test_response == "Yes")
fp <- sum(knn_predictions == "Yes" & test_response == "No")
tn <- sum(knn_predictions == "No" & test_response == "No")
fn <- sum(knn_predictions == "No" & test_response == "Yes")

accuracy <- (tp + tn) / (tp + tn + fp + fn)
precision <- tp / (tp + fp)
specificity <- tn / (tn + fp)
recall <- tp / (tp + fn)
f1_score <- 2 * precision * recall / (precision + recall)

# Print the classification metrics
cat("Accuracy:", round(accuracy, 4), "\n")
cat("Precision:", round(precision, 4), "\n")
cat("Specificity:", round(specificity, 4), "\n")
cat("Recall:", round(recall, 4), "\n")
cat("F1 Score:", round(f1_score, 4), "\n")
