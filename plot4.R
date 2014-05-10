# Create an multiple x-y plots

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

# mulitple plots
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# Global active power
plot(Global_active_power ~ datetime, data=epc2, xlab="", ylab="Global Active Power (kilowatts)", type="l")

# Voltage
plot(Voltage ~ datetime, data=epc2, xlab="", ylab="Voltage", type="l")

# Energy sub metering 
plot(Sub_metering_1 ~ datetime, data=epc2, xlab="", ylab="Enegy sub metering", type="l")
lines(Sub_metering_2 ~ datetime, data=epc2, col="red")
lines(Sub_metering_3 ~ datetime, data=epc2, col="blue")
legend("topright", cex=0.7, lty=1, bty="n",
       col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Global reactive power
plot(Global_reactive_power ~ datetime, data=epc2, type="l")

dev.off()
