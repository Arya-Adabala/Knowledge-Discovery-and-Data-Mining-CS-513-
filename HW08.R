# Loading the Breast Cancer Wisconsin dataset and display summary statistics
rm(list=ls())
data_bc <- read.csv("C:/breast-cancer-wisconsin.csv", header = TRUE, na.strings = "?")
summary(data_bc)
table(data_bc$diagnosis)

# Cleaning the dataset by removing missing values and dropping the ID column
data_bc <- na.omit(data_bc)
data_bc <- data_bc[-1]

# Performing hierarchical clustering
dist_bc <- dist(data_bc[, -1])
hc_bc <- hclust(dist_bc)
plot(hc_bc)
hc_2 <- cutree(hc_bc, 2)
table(hc_2, data_bc[,1])

# Performing k-means clustering
rm(list=ls())
data_bc <- read.csv("C:/breast-cancer-wisconsin.csv", header = TRUE, na.strings = "?")
data_bc <- na.omit(data_bc)
data_bc <- data_bc[-1]
kmeans_bc <- kmeans(data_bc[, -1], centers = 2, nstart = 10)
table(kmeans_bc$cluster, data_bc[,1])

