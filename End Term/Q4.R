#Arya Adabala 
# Clearing the environment
rm(list=ls())

# Loading the required libraries
library(tidyverse)
library(cluster)

# Loading the dataset and removing missing values
df <- read.csv("C:/absenteeism_0.csv", na.strings = c(""))
df <- na.omit(df)

# Removing the Abs_cat column
df2 <- df %>% select(-Abs_cat)

# Performing hierarchical clustering
dist_mat <- dist(df2, method = "euclidean")
hc <- hclust(dist_mat, method = "ward.D2")

# Plotting the dendrogram to determine the number of clusters
plot(hc)

# Determining the number of clusters (in this case, we can see that 3 clusters would be appropriate)
num_clusters <- 3

# Performing K-means clustering
set.seed(123) # for reproducibility
kmeans_res <- kmeans(df2, centers = num_clusters)

# Appending the cluster assignments to the original dataset
df$cluster <- kmeans_res$cluster

# Creating a table of the cluster assignments and Abs_cat
cluster_table <- table(df$cluster, df$Abs_cat)
print(cluster_table)

# Calculating the centroids of each cluster
centroids <- kmeans_res$centers
colnames(centroids) <- colnames(df2)

# Printing the centroids
print(centroids)

# Plotting the clusters based on the first two variables (Transportation_expense and Distance_from_Residence_to_Work)
ggplot(df, aes(x = Transportation_expense, y = Distance_from_Residence_to_Work, color = factor(cluster))) +
  geom_point() +
  labs(title = "K-means Clustering of Employee Absenteeism",
       x = "Transportation expense",
       y = "Distance from residence to work",
       color = "Cluster") +
  theme_bw()
