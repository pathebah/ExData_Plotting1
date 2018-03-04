library(dplyr)

#read the data
pdata <- subset(read.table("household_power_consumption.txt",
                           sep = ";", header = TRUE),
                as.character(Date) == "1/2/2007" | 
                  as.character(Date) == "2/2/2007")

#convert date and time to appropriate formats for analysis

dt <- paste(as.character(pdata$Date),
            as.character(pdata$Time),sep = " ") 
dt <- as.POSIXct(dt, format = "%d/%m/%Y %H:%M:%S")
pdata <- pdata %>% mutate(DateTime = dt)

#Plot 4 - Group
par(mfrow = c(2,2))

#Global active power
with(pdata, plot(DateTime, as.numeric(Global_active_power)/1000, 
                 type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#Voltage
with(pdata, plot(DateTime, Voltage, 
                 type = "l", xlab = "", ylab = "Voltage"))

#Energy Sub metering
with(pdata, plot(DateTime, Sub_metering_1, 
                 type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
lines(pdata$DateTime, pdata$Sub_metering_2, col = "red")
lines(pdata$DateTime, pdata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_meteging_1","Sub_meteging_2","Sub_meteging_3"), 
       box.lty = 0, col = c("black","red","blue"), lwd = 1, cex = 0.4)

#Global reactive power
with(pdata, plot(DateTime, as.numeric(Global_reactive_power)/1000, 
                 type = "l", xlab = "", ylab = "Global Reactive Power (kilowatts)"))
#Copy plot 4 to file
dev.copy(png, file = "plot4.png", width = 480, height = 480, pointsize = 15)
dev.off()
par(mfrow = c(1,1))