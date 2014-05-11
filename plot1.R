
rm(list = ls())
initial <- read.table("household_power_consumption.txt", 
                      nrow = 100000, comment.char="", 
                      header=TRUE, sep = ";", 
                      stringsAsFactors=FALSE, na.strings = "?")
classes <- sapply(initial, class)
classes
str(initial)
summary(initial)
classNames <- colnames(initial)


z <- as.POSIXct("2006-12-16 17:24:00")
x <- as.POSIXct("2006-12-17 00:00:00")
y <- as.POSIXct("2007-02-01 00:00:00")
minutes = as.numeric(x - z) * 60 + 1
days = as.numeric(y - x)

linesToSkip = days * 24 * 60 + minutes
linesToRead = 2 * 24 * 60

hpc <- read.table("household_power_consumption.txt", 
                  skip = linesToSkip, 
                  nrow = linesToRead, 
                  sep = ";", colClasses=classes,
                  col.names = colnames(initial))


hist(hpc$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col= "red", 
     main="Global Active Power")

png(filename = "plot1.png", width = 480, height = 480)
hist(hpc$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col= "red", 
     main="Global Active Power")
dev.off()


