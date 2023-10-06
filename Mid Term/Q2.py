import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load the dataset
df = pd.read_csv("C:\CS513_targeting_num.csv")

# Summarize each numerical column
summary = df.describe()
print(summary)

# Identify missing values
print(df.isnull().sum())

# Replace numerical missing values with the median of the corresponding columns
df.fillna(df.median(), inplace=True)

# Create a scatter plot of "Age" and "Income"
plt.scatter(df['Age'], df['Income'])
plt.xlabel('Age')
plt.ylabel('Income')
plt.title('Scatter plot of Age vs. Income')
plt.show()

# Create box plots for columns "Age" and "Income"
df.boxplot(column=['Age', 'Income'])
plt.title('Box plot of Age and Income')
plt.show()
