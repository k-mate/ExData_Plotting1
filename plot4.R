
# download project data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# read data
library(readr)
df = read_delim(file = "data/household_power_consumption.txt", delim = ";", col_names = TRUE)
# clean data
library(tidyverse)
library(lubridate)
df1 <- df %>% 
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(datetime = make_datetime(year(Date), month(Date), day(Date), 
                                  hour(Time), minute(Time), second(Time)))

# Plot 4
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2,2))

## 4.1
plot(y = df1$Global_active_power, x = df1$datetime, type = "l", 
     ylab = "Global Active Power",
     xlab = "")

## 4.2
with(df1, plot(y = Voltage, x = datetime, type = "l"))

## 4.3
with(df1, plot(y = Sub_metering_1, x = datetime, type = "l", col = "black",
                 ylab = "Energy sub metering", xlab = ""))

with(df1, points(y = Sub_metering_2, x = datetime, type = "l", col = "red"))

with(df1, points(y = Sub_metering_3, x = datetime, type = "l", col = "blue"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1,1,1), border = "white", bty = "n")

## 4.4
with(df1, plot(y = Global_reactive_power, x = datetime, type = "l"))

dev.off()
