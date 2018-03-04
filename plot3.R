# Load packages into R
library(readr)
library(dplyr)

# Read data into R
pdata <- read_delim("household_power_consumption.txt",
                    delim = ";",
                    locale = locale(decimal_mark = "."), 
                    na = "?",
                    col_types = list(col_date(format = "%d/%m/%Y"),
                                     col_time(format = "%H:%M:%S"),
                                     "n", "n","n","n","n","n","n"))
# subset data
pdata <- pdata %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time)))

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
