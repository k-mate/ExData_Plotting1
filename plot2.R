
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

# Plot 2
par(mfrow = c(1,1))
png(file="plot2.png", width=480, height=480)
plot(y = df1$Global_active_power, x = df1$datetime, type = "l", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()

