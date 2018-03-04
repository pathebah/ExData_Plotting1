# Load necessary packages into R session
library(readr)
library(dplyr)

# Read data into R, initializing column types
pdata <- read_delim("household_power_consumption.txt",
                    delim = ";",
                    locale = locale(decimal_mark = "."), 
                    na = "?",
                    col_types = list(col_date(format = "%d/%m/%Y"),
                                     col_time(format = "%H:%M:%S"),
                                     "n", "n","n","n","n","n","n"))
# Filter rows to appropriate dates
pdata <- pdata %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
  # Combine Date and Time into new column: datetime
  mutate(DateTime = as.POSIXct(paste(Date, Time)))

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