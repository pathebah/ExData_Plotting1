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

#Plot 1 - histogram
par(mfrow = c(1,1))
hist(as.numeric(pdata$Global_active_power)/1000, 
     col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()



 
 
 
 
 
 