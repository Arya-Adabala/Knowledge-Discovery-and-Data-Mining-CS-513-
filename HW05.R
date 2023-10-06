# Loading the required libraries
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(rattle)

# Importing the breast cancer dataset and view its contents
breast_cancer_data <- read.csv("C:/breast-cancer-wisconsin.csv")
View(breast_cancer_data)

# Renaming the "Class" column and convert it to a factor with meaningful labels
breast_cancer_data$Class <- factor(breast_cancer_data$Class, levels = c(2, 4), labels = c("Benign", "Malignant"))

# Setting the seed for reproducibility
set.seed(111)

# Randomly splitting the data into training and test datasets
index <- sort(sample(nrow(breast_cancer_data), as.integer(0.3 * nrow(breast_cancer_data))))
training_data <- breast_cancer_data[-index, ]
test_data <- breast_cancer_data[index, ]

# Training a classification tree model using the training dataset
cart_model <- rpart(Class ~ ., data = training_data)
summary(cart_model)

# Visualizing the classification tree
rpart.plot(cart_model)

# Making predictions on the test dataset using the trained model
cart_predictions <- predict(cart_model, test_data, type = "class")

# Printing a frequency table to compare actual vs. predicted classes
table(Actual = test_data[, "Class"], Predicted = cart_predictions)

# Calculate and print the accuracy of the model on the test dataset
accuracy <- mean(test_data[, "Class"] == cart_predictions)
cat("The accuracy of the CART model on the test dataset is:", accuracy, "\n")

# Calculate and print the error rate of the model on the test dataset
error_rate <- 1 - accuracy
cat("The error rate of the CART model on the test dataset is:", error_rate, "\n")

# Visualizing the classification tree with fancy formatting
fancyRpartPlot(cart_model)

