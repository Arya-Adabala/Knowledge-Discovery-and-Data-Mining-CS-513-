# First, we check if the 'kknn' package is installed and install it if not
if (!require("kknn")) {
  install.packages("kknn")
}

# Importing the Breast Cancer Dataset
breast_cancer <- read.csv("C:/breast-cancer-wisconsin.csv", na.strings = '?')

# Removing any missing data from the dataset
breast_cancer_clean <- na.omit(breast_cancer[, -1])

# Converting the "Class" column to a factor data type
breast_cancer_clean$Class <- as.factor(breast_cancer_clean$Class)

# Splitting the data into 70% training and 30% test data
idx <- sample(nrow(breast_cancer_clean), as.integer(.70 * nrow(breast_cancer_clean)))
training <- breast_cancer_clean[idx, ]
test <- breast_cancer_clean[-idx, ]

# Installing the required packages for k-nearest neighbor classification
library(kknn)
library(caret)

# Performing k-nearest neighbor classification with different values of k
for (k in c(3, 5, 7)) {
  predict_k <- kknn(formula = Class ~ ., training, test, k = k, kernel = "rectangular")
  fit <- fitted(predict_k)
  tbl <- table(Actual = test$Class, Fitted = fit)
  cat(paste("For k =", k, ":\n"))
  print(tbl)
}

