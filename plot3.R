# plot3.R -> Energy Sub Metering (details)
# Course/Assignment: Coursera > Johns Hopkins > Data Science Specialization > Course 04: Exploratory Data Analysis > Week 1 Programming Assignment
# Creator: Dan Charlson coursera@dancha.com
# Date Created: 2023-01-24
# 
## Intro: Making Plots
# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
# First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1
# For each plot you should
# 1. Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 2. Name each of the plot files as plot1.png, plot2.png, etc.
# 3. Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file.
# 4. Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)
# When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. There should be four PNG files and four R code files, a total of eight files in the top-level folder of the repo.



## Preliminaries and Assumptions
# That all the .R files will be called from a working directory that (should) contain a /data subdir,
# where the data file will be deposited once acquired.

# Set the working directory
setwd("/Users/dancharlson/Dropbox/Courses/Coursera/04_Exploratory Data Analysis/Week01")

## Steps

# 0. Load any libraries needed
# Install and load package(s)
install.packages("tidyverse")
library(tidyverse)


# 1. Obtain file

if (!file.exists("./data")) {
    dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip")
list.files("./data")

# 2. Read from file the desired data (only: 2007-02-01 and 2007-02-02)
# 3. Perform any cleanup or organization if needed (this functionality in this called file)

# read in all the data (I spent hours trying to get just the two days BEFORE doing this, to no avail)
tempdata <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?", stringsAsFactors = FALSE)

# convert the Date column's char data to actual date
tempdata$Date <- as.Date(tempdata$Date, format = "%d/%m/%Y")

# extract just the two desired days: 1st and 2nd of Feb, 2007
Feb2days <- subset(tempdata, Date == "2007-02-01" | Date == "2007-02-02")

# get rid of the 2M+ rows of original data
rm(tempdata)

# Do the same merging of Date & Time as in plot2.R
Feb2days <- Feb2days %>% mutate(Date_Time = as.POSIXct(paste(Feb2days$Date, Feb2days$Time), format="%Y-%m-%d %H:%M:%S"))


# 4. Create the plot; see spec above/online
# The key here is having all three Sub Metering values, divided by color, AND listed in the little box

png("plot3.png", width=480, height=480)
with(Feb2days, plot(Date_Time, Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering"))
lines(Feb2days$Date_Time, Feb2days$Sub_metering_2,type="l", col= "red")
lines(Feb2days$Date_Time, Feb2days$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()
    
