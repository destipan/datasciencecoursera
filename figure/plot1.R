household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE, dec=".")
data <- subset(household, Date == c('1/2/2007','2/2/2007'))
Global_active_power <- as.numeric(data$Global_active_power)
hist(Global_active_power, main = 'Global Active Power', xlab = "Global Active Power (kilowatts)", col = 'red', ylab = "Frequency")