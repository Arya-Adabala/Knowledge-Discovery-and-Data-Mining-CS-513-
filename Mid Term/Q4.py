# Load the required libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.naive_bayes import GaussianNB
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix

# Loading the dataset
data = pd.read_csv('C:\CS513_targeting_cat_full.csv')

# Checking for null values
if data.isnull().values.any():
    print("The dataset contains missing values.")
else:
    # Converting the categorical data to numeric using pandas get_dummies method
    data = pd.get_dummies(data, columns=["Age", "Gender", "Region", "Product"])

    # Dropping the age column because it is categorical data and dropping the last column of the data
    X = data.drop(columns=["Purchase"])
    y = data["Purchase"]

    # Splitting the data such that training data is 70% and testing data is 30%
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)

    # Initializing the model
    model = GaussianNB()

    # Training the model
    model.fit(X_train, y_train)

    # Predicting the purchase for the 30% of the random sample of the dataset and storing it into y_pred
    y_pred = model.predict(X_test)

    # Calculating accuracy, precision, recall, F1 score
    accuracy = accuracy_score(y_test, y_pred)
    precision = precision_score(y_test, y_pred, pos_label='Yes')
    recall = recall_score(y_test, y_pred, pos_label='Yes')
    f1 = f1_score(y_test, y_pred, pos_label='Yes')

    print('Accuracy:', accuracy)
    print('Precision:', precision)
    print('Recall:', recall)
    print('F1 score:', f1)

    # Calculating specificity using confusion matrix
    tn, fp, fn, tp = confusion_matrix(y_test, y_pred).ravel()
    specificity = tn / (tn+fp)

    print('Specificity:', specificity)
