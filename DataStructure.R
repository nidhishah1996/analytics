#Data Structures in R

#vectors----
#4 dash is ussed to bookmark the part of the code

v1 = 10
v1
print (v1)

v2 = 1:100 #used to create a list with sequence from 1 to 100
length(v2)

v3 = c(1,6,4,10) #used to concatenate differnt number
(v3 = c(1,6,4,10)) # putting brackets around v3 is used to create and print at the same time

v4 = seq(1,100,5) #create a vector with a difference of 5 between each
v4

v5 = c('A','Nidhi', 'IIFT')
v5
class(v5) # both single and double inverted commas refer to string

v6 = 1:10000000
v6

(v7 = rnorm(100,mean=60,sd = 10)) #random normal form
mean(v7)
v7[1:10] #to extract top 10 data values
v7[seq(1,100,2)] # to select every alternate data
v7[v7>50] #select data whose value is greater than 50
v7[v7 < 70 & v7 >60]
mean(v7[v7 < 70 & v7 >60])
v7[v7 < 70 | v7 >60]
v7[2]
plot(v7)
hist(v7)
plot(density(v7)) #to check distribution form - normal
hist(v7,breaks=10)
quantile(v7)
summary(v7)
quantile(v7,seq(0,1,0.1)) #decile:divide into 10 groups
quantile(v7,seq(0,1,0.01)) #divide into 100 groups
sort(v7) #increasing data
sort(v7, decreasing =TRUE ) #decreasing form
?hist

#matrix-----
(data = 24:1)

v12 = c(1,3,'A')
v13 = 1:10
v13 +2
v13/sum(v13)


m1 = matrix(data)
m1
m2 = matrix(data, nrow = 4) #no of rows need to be divisibe by total no of values in the matrix
m2
m2 = matrix(data, nrow = 5)
m2
(m3 = matrix(data, nrow = 4, byrow = T))
m2[1,]
m2[,1] # the columns are also printed as row items
m2[,c(1,3)] #data from first and third column
m2[c(1,4), c(2,4,5)]
rowSums(m2)
colSums(m2)
rowMeans(m2)
colMeans(m2)

table(mtcars$cyl)
t1 = table(mtcars$cyl, mtcars$gear, dnn=c('cyl','gear')) #cross-tabs
margin.table(t1) #sum of all data values in the matrix
margin.table(t1,margin=1) 
#sum of data, grouped by row-wise when margin=1 
#and grouping by column wise is margin=2
addmargins(t1) #extra column and row is added, to calc sum row-wise and column-wise
addmargins(t1, FUN = mean)
addmargins(t1, FUN = list(list(mean,sum),list(sd,var)))

sweep(m2,MARGIN = 1,STATS = 4, FUN = '+') #need matrix data and here, every row is added by 4 since stats is 4 and function is 4
sweep(m3,MARGIN = 1,STATS = c(1,2,3,4), FUN = '*') 
sweep(m3,MARGIN = 2,STATS = c(1,2,3,4,5,6), FUN = '*') 
?sweep
m2

#dataframe----
data()
AirPassengers
class(AirPassengers)
dim(mtcars) #dimensions of the dataframe
nrow(mtcars) #number of row
names(mtcars) # names of the column
ncol(mtcars) 
mtcars
rownames(mtcars)
colnames(mtcars)
summary(mtcars)


#summarizing / filter data from DF----
mtcars[mtcars$gear == 4, ] #all rows where no of gears is 4
# = : equal to and == : checking for equality and returns true or false
mtcars[mtcars$gear == 4 & mtcars$mpg > 25, c('mpg','gear', 'cyl')]
mtcars[order(mtcars$mpg),] # sort dataframe based on column value
mtcars[rownames(mtcars) == 'Mazda RX4', ]
mtcars[c(1,3,4),c(1,5)]

#export to csv----
write.csv(mtcars,'nidhi.csv')
df1 = read.csv('nidhi.csv')
head(df1)
nrow(df1)
ncol(df1)
write.csv(mtcars, 'nidhi2.csv', row.names = F) #because the first row which is header is taken as data
df2 = read.csv('nidhi2.csv')
head(df2)
(carnames = paste('car',1:32,sep=':'))
df2$cars = carnames  
df2

#create a dataframe such that it contains rollno,name,gender,marks,grade

rollno = 1:30
(name = paste('student',1:30))
set.seed(123) # used to create same set of random numbers even on running it again
gender = sample(c('M','F'),size=30, replace=T)
gender2 = sample(c('M','F'),size=30, replace=T, prob = c(0.6,0.4))
table(gender2)
prop.table(table(gender2)) #calculate the proportional probability
marks = sample(35:100, size = 30, replace=T) #can also be done through uniform distribution and normal distribution
marks2 = runif(30,min=50,max=100)
grade = sample(c('A','B','C'),size=30,replace=T,prob=c(0.2,0.45,0.25))
prop.table(table(grade))

x = c(-14.45,-18.56,56.45,89.14,53)
trunc(x)
round(x)
floor(x)
ceiling(x)

rollno;name;gender;marks;grade
student = data.frame(rollno,name,gender,marks,grade)
student
head(student)
str(student)
#factor in R refers to category class
summary(student)
student$name = as.character(student$name)
student$grade = factor(student$grade,ordered =T, levels = c('C','B','A')) #to convert nominal to ordinal data form
student$grade
table(student$grade) #the data is present in ordered form
barplot(table(student$grade), col=1:3)
hist(student$marks)
range(student$marks)
hist(student$marks,breaks=c(0,70,90,100))

student[student$gender=='M' & student$marks>70,]

library(dplyr)

student %>% filter(gender =='M'& marks > 70)
# %>% === piping function


student %>% filter(gender =='M'& marks > 70) %>% arrange(marks) %>% head(n=3) %>% select(rollno, name)
