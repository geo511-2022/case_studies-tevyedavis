#read in the data
data(iris)

#select a column and create a variable name
Petal_Length<-iris$Petal.Length

#calculates a statistic from the column 
#and save it as an object named petal_length_mean
petal_length_mean <-mean(Petal_Length)
petal_length_mean

#make a histogram plot
hist(Petal_Length)

