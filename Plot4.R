## Download the file to load and unzip it

if (!file.exists("data")){
        dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")

unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data")

## Load and create Data

HPC_Data <- read.csv('./data/household_power_consumption.txt', header = TRUE, sep = ';', na.strings = "?")
head(HPC_Data)

HPC_Goal_Data <- HPC_Data[HPC_Data$Date %in% c("1/2/2007","2/2/2007"),]
head(HPC_Goal_Data)

# Convert in data/time info in format  'm/d/y h:m:s'
x <- paste(HPC_Goal_Data$Date, HPC_Goal_Data$Time)
SetTime <- strptime(x, "%d/%m/%Y %H:%M:%S")

FinalData <- cbind(HPC_Goal_Data, SetTime)

## Plot 4

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(FinalData, {
        plot(FinalData$Global_active_power ~ FinalData$SetTime, type="l", col="black", xlab="", ylab="Global Active Power")
        plot(FinalData$Voltage ~ FinalData$SetTime, type="l", col="black", xlab="datetime", ylab="Voltage")
        plot(FinalData$Sub_metering_1 ~ FinalData$SetTime, type="l", xlab = "", ylab = "Energy sub metering", col = "black")
        lines(FinalData$Sub_metering_2 ~ FinalData$SetTime, col = "red")
        lines(FinalData$Sub_metering_3 ~ FinalData$SetTime, col = "blue")
        plot(FinalData$Global_reactive_power ~ FinalData$SetTime, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()