#Unzipping and downloading required data to be merged
install.packages("dplyr")
install.packages("data.table")
library(dplyr)
library(data.table)

#unzip to a temp folder and a temp file
url1<-
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <-tempfile()
tempd<-tempdir()
download.file(url1,temp,quiet=TRUE, mode="w")
EPC<- fread(unzip(file.path(temp), exdir = tempd), na.strings = c("?"), 
            stringsAsFactors = FALSE)
names(EPC)<-make.names(names(EPC))
EPC$dateTime<-paste(EPC$Date,EPC$Time)
class(EPC$dateTime)
EPC$dateTime<-as.POSIXct(strptime(EPC$dateTime, format="%d/%m/%Y %H:%M:%S"))
class(EPC$dateTime)
EPC_F<-filter(EPC, dateTime >= as.POSIXct("2007-02-01 00:00:00") & dateTime<
                as.POSIXct("2007-02-02 24:00:00"))

#2 Plot Chart
png("plot2.png", width = 480, height = 480)
plot(EPC_F$Global_active_power~EPC_F$dateTime,type='l', 
     ylab = "Global Active Power(kilowatt)", xlab = "")
dev.off()