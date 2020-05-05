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

###Plot
plot(power_consumption_data$Global_active_power~power_consumption_data$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

###Saving as png
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
