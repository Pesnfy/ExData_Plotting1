"loading"
epc <- read.table("household_power_consumption.txt", header=T, sep=";")
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
" picking the first two days of Febuary"
data <- epc[(epc$Date=="2007-02-01") | (epc$Date=="2007-02-02"),]
"cleaning"
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data <- transform(data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
# PLot 3
plot3 <- function() {
        plot(data$timestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(data$timestamp,data$Sub_metering_2,col="red")
        lines(data$timestamp,data$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
        dev.copy(png, file="plot3.png", width=480, height=480)
        dev.off()
        cat("plot3.png has been saved in", getwd())
}
plot3()
