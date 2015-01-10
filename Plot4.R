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
# Plot 4
plot4 <- function() {
        par(mfrow=c(2,2))
       
        ##PLOT i
        plot(data$timestamp,data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        ##PLOT ii
        plot(data$timestamp,data$Voltage, type="l", xlab="datetime", ylab="Voltage")
        ##PLOT iii
        plot(data$timestamp,data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(data$timestamp,data$Sub_metering_2,col="red")
        lines(data$timestamp,data$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        #PLOT iv
        plot(data$timestamp,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
       
        #OUTPUT
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()
