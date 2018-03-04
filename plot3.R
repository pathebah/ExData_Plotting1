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

#Plot 3 - Energy sub metering
par(mfrow = c(1,1))
with(pdata, plot(DateTime, Sub_metering_1, 
                 type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
lines(pdata$DateTime, pdata$Sub_metering_2, col = "red")
lines(pdata$DateTime, pdata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_meteging_1","Sub_meteging_2","Sub_meteging_3"), 
       box.lty = 1, col = c("black","red","blue"), lwd = 1)
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()