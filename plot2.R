# Create an x-y plot of Global Active power for 2 days

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

# Global active power
plot(Global_active_power ~ datetime, data=epc2, xlab="", 
     ylab="Global Active Power (kilowatts)", type="l", width = 480, height = 480)
dev.copy(png, file="plot2.png")
dev.off()
