
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

datetime <- strptime(paste(hpc[,1], hpc[,2]), "%d/%m/%Y %H:%M:%S")


par(mfcol = c(2, 2))

plot(datetime, hpc$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")

plot(datetime, hpc$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(datetime, hpc$Sub_metering_2, type="l", col="red")
lines(datetime, hpc$Sub_metering_3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty=1, bty = "n", cex = 1)

plot(datetime, hpc$Voltage, ylab="Voltage", type="l")
plot(datetime, hpc$Global_reactive_power, 
     ylab="Global_reactive_power", 
     type="l")






png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

plot(datetime, hpc$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")

plot(datetime, hpc$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(datetime, hpc$Sub_metering_2, type="l", col="red")
lines(datetime, hpc$Sub_metering_3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty=1, bty = "n", cex = 1)

plot(datetime, hpc$Voltage, ylab="Voltage", type="l")
plot(datetime, hpc$Global_reactive_power, 
     ylab="Global_reactive_power", 
     type="l")
dev.off()
par(mfcol=c(1, 1))

