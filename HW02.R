rm(list = ls())

#Loading the breast cancer dataset
name <- file.choose()
dataset <- read.csv(name)


# i) Summarizing each column (e.g. min, max, mean )
summary(dataset['Sample'])
summary(dataset['F1'])
summary(dataset['F2'])
summary(dataset['F3'])
summary(dataset['F4'])
summary(dataset['F5'])
summary(dataset['F6'])
summary(dataset['F7'])
summary(dataset['F8'])
summary(dataset['F9'])


# ii) Identifying missing values
dataset[,1:11][dataset[,1:11]=="?"]<- NA
View(dataset)
colSums(is.na(dataset))


# iii) Replacing the missing values with the "mean" of the column.
for(i in names(dataset)){
  if((any(is.na(dataset[,i])))){
    
    dataset[is.na(dataset[,i]),i]<-mean(as.numeric(dataset[,i]),na.rm = TRUE)
  }
  
}
colSums(is.na(dataset))
View(dataset)

#dataset$F6 <- as.numeric(dataset$F6)
#?mean()
#mean = mean(dataset$F6,na.rm = TRUE)
#dataset[is.na(dataset$F6),"F6"]<-mean
#colSums(is.na(dataset))


# iv) Displaying the frequency table of "Class" vs. F6
?table()
tb <- table(dataset$F6,dataset$Class)
ftable(tb)


# v) Displaying the scatter plot of F1 to F6, one pair at a time
plot(x = dataset$F1,y = dataset$F2,xlab = "F1",ylab = "F2",xlim = c(0,12),ylim = c(0,12), main = "F1 VS F2",col="red")
plot(x = dataset$F2,y = dataset$F3,xlab = "F2",ylab = "F3",xlim = c(0,12),ylim = c(0,12), main = "F2 VS F3",col="red")
plot(x = dataset$F3,y = dataset$F4,xlab = "F3",ylab = "F4",xlim = c(0,12),ylim = c(0,12), main = "F3 VS F4",col="red")
plot(x = dataset$F4,y = dataset$F5,xlab = "F4",ylab = "F5",xlim = c(0,12),ylim = c(0,12), main = "F4 VS F5",col="red")
plot(x = dataset$F5,y = dataset$F6,xlab = "F5",ylab = "F6",xlim = c(0,12),ylim = c(0,12), main = "F5 VS F6",col="red")
plot(x = dataset$F6,y = dataset$F1,xlab = "F6",ylab = "F1",xlim = c(0,12),ylim = c(0,12), main = "F6 VS F1",col="red")

plot(dataset[2:7],main="Scatter Plot of F1 to F6")


# vi) Show histogram box plot for columns F7 to F9
hist(dataset$F7,main=paste("Histogram of F7"),col='red')
hist(dataset$F8,main=paste("Histogram of F8"),col='lightGrey')
hist(dataset$F9,main=paste("Histogram of F9"),col='green')
?hist()
boxplot(dataset[8:10], main = "Histogram Box Plot for Columns F7 to F9")



# Remove any row with a missing value in any of the columns.
rm(list = ls())
df = file.choose()
dats = read.csv(df)
dats[,1:11][dats[,1:11]=="?"]<- NA
dats<-na.omit(dats)
colSums(is.na(dats))
View(dats)
