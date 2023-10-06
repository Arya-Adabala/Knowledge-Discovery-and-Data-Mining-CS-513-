#Clearing the workspace
rm(list=ls())
# Installing and loading the neuralnet package
install.packages('neuralnet')
library(neuralnet)

# Reading the dataset wnd Loading the data
filename <- file.choose()
data <- read.csv(filename)

# Removing rows with missing values from the dataset
data <- na.omit(data)

# Spliting the dataset into training and testing sets
train_indices <- sort(sample(nrow(data), as.integer(0.7 * nrow(data))))
training_data <- data[train_indices, ]
testing_data <- data[-train_indices, ]

# Creating a neural network model with one hidden layer of 5 neurons
neural_network <- neuralnet(diagnosis ~ ., training_data[-1], hidden = 5, threshold = 0.01)

# Plot the neural network
plot(neural_network)

# Making predictions on the testing set
testing_inputs <- testing_data[, -1]
ann_output <- compute(neural_network, testing_inputs)
predicted_output <- ifelse(ann_output$net.result < 1.5, 1, 2)
predicted_output

