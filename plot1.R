# Load packages into R
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
  mutate(DateTime = as.POSIXct(paste(Date, Time)))

#Plot 1 - histogram
par(mfrow = c(1,1))
hist(pdata$Global_active_power, 
     col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()



 
 
 
 
 
 