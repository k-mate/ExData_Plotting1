
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

# Plot figure 1
par(mfrow = c(1,1))
png(file="plot1.png", width=480, height=480)
hist(df1$Global_active_power,
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main =  "Global Active Power",
     breaks = 18,
     axes = FALSE)
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))
axis(side=2, at=seq(0,1200,200), labels=seq(0,1200,200))
dev.off()
