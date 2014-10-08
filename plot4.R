library(sqldf)
desiredData <- read.csv.sql(file = "household_power_consumption.txt", header = T,sep = ";",sql = "select * from file where Date = '1/2/2007' or date = '2/2/2007'")
dataTimestamp <- paste(desiredData$Date,desiredData$Time)
drops <- c("Date","Time")
newData <- desiredData[,!(names(desiredData) %in% drops)]
times <- strptime(x = dataTimestamp,format = "%d/%m/%Y %H:%M:%S")
newData <- cbind(times,newData)
png(filename = "plot4.png",bg = "transparent")
par(mfcol = c(2, 2))
#1
with(newData, plot(Global_active_power ~ times, ylab = "Global Active Power", xlab = NA, type='l'))
#2
plot(newData$Sub_metering_1 ~ newData$times,type="n",ylab = "Energy sub metring",xlab = NA)
lines(newData$Sub_metering_1 ~ newData$times, col = "black")
lines(newData$Sub_metering_2 ~ newData$times,col = "Red")
lines(newData$Sub_metering_3 ~ newData$times,col = "Blue")
#3
plot(newData$Voltage ~ newData$times,type="l",ylab = "Voltage",xlab = "datetime")
#4
plot(newData$Global_reactive_power ~ newData$times,type="l",ylab = "Global_reactive_power",xlab = "datetime")
dev.off()