library(data.table)

if (file.exists("household_power_consumption.txt")){
  print("File Exists")
} else {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip",  method="curl")
  unzip("household_power_consumption.zip")
}

dt <- read.table("household_power_consumption.txt", header=TRUE, quote="", na.strings=c("?", ""), sep=";")
dt$Date2 <- as.Date(as.character(dt$Date,"%d/%m/%Y"), "%d/%m/%Y")
household = subset(dt, Date2==as.Date("2007-02-01") | Date2==as.Date("2007-02-02"))
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)

hist(household$Global_active_power, breaks= 15, xlab="Global Active Power (Kilowats)", main="Global Active Power", col="red")
dev.off()