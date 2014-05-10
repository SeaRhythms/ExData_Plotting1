# Create an x-y plot of the 3 submetering for 2 days

# read data
epc <- read.table("household_power_consumption.txt", header=T, stringsAsFactor=F, sep=";", na.strings="?")

# remove missing values
epc <- na.omit(epc)

# select relevant records
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")
epc2 <-  subset(epc, epc$Date == "2007-02-01" | epc$Date == "2007-02-02")

# add datetime column
datetime <- as.POSIXct(strptime(paste(epc2$Date, epc2$Time) , "%Y-%m-%d %H:%M:%S"))
epc2 <- cbind(epc2, datetime)

# Energy sub metering 
png(filename = "plot3.png", width = 480, height = 480)

plot(Sub_metering_1 ~ datetime, data=epc2, xlab="", 
     ylab="Enegy sub metering", type="l", width = 480, height = 480)
lines(Sub_metering_2 ~ datetime, data=epc2, col="red")
lines(Sub_metering_3 ~ datetime, data=epc2, col="blue")
legend("topright", cex=0.9, lty=1, 
       col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()