###Load data
power_consumption_data <- read.table("household_power_consumption.txt",sep = ";", na.strings = "?", header = TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

### Converting Date column to Date class
power_consumption_data$Date <- as.Date(power_consumption_data$Date, "%d/%m/%Y")

### Subset data from 01-02-2007 and 02-02-2007
power_consumption_data <- subset(power_consumption_data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

### Collecting complete data
power_consumption_data <- power_consumption_data[complete.cases(power_consumption_data),]

## Combine Date and Time column
dateTime <- paste(power_consumption_data$Date, power_consumption_data$Time)

###Name the vector
dateTime <- setNames(dateTime, "DateTime")

###Remove Date and Time column
power_consumption_data <- power_consumption_data[ ,!(names(power_consumption_data) %in% c("Date","Time"))]

###Add DateTime column
power_consumption_data <- cbind(dateTime, power_consumption_data)

###Format dateTime Column
power_consumption_data$dateTime <- as.POSIXct(dateTime)

###Diving the canvas
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

###Plot 1
plot(power_consumption_data$Global_active_power~power_consumption_data$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

###Plot2
with(power_consumption_data, plot(Voltage ~ dateTime, type = "l"))


###Plot3
with(power_consumption_data, plot(Sub_metering_1 ~ dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(power_consumption_data, lines(Sub_metering_2 ~ dateTime, col = 'Red'))
with(power_consumption_data, lines(Sub_metering_3 ~ dateTime, col = 'Blue'))

###Writing Legend
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

###Plot4
with(power_consumption_data,plot(Global_reactive_power ~ dateTime, type = "l"))

    
    
###Saving as png
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()