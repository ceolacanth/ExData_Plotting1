library(data.table)

if (file.exists("household_power_consumption.txt")){
  print("File Exists")
} else {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip",  method="curl")
  unzip("household_power_consumption.zip")
}

dt <- read.table("household_power_consumption.txt", header=TRUE, quote="", na.strings=c("?", ""), sep=";")
dt$Date2 <- as.Date(as.character(dt$Date,"%d/%m/%Y"), "%d/%m/%Y")
dt$DateTimeText <- do.call(paste, c(dt[c("Date", "Time")], sep = " "))
dt$DateTime <- as.POSIXct(strptime(dt$DateTimeText, '%d/%m/%Y %H:%M:%S')) 

household = subset(dt, Date2==as.Date("2007-02-01") | Date2==as.Date("2007-02-02"))
household$day_name <- weekdays(household$DateTime)
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white",  res = NA)
plot( household$Sub_metering_1 ~ household$DateTime, type="l", col="black", xlab="", ylab="Energy Sub Metering" )
lines(household$Sub_metering_2 ~ household$DateTime, type="l", col="red")
lines(household$Sub_metering_3 ~ household$DateTime, type="l", col="blue")
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c('black','red','blue'), lwd=c(2.5,2.5))
dev.off()