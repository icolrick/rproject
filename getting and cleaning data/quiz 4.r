

library("data.table")
communities <- data.table::fread("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
varNamesSplit <- strsplit(names(communities), "wgtp")
varNamesSplit[[123]]

GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                    , skip=5
                    , nrows=190
                    , select = c(1, 2, 4, 5)
                    , col.names=c("CountryCode", "Rank", "Country", "GDP")
)

GDPrank[, mean(as.integer(gsub(pattern = ',', replacement = '', x = GDP )))]


grep("^United",GDPrank[, Country])


GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                             , skip=5
                             , nrows=190
                             , select = c(1, 2, 4, 5)
                             , col.names=c("CountryCode", "Rank", "Country", "GDP")
)

eduDT <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

mergedDT <- merge(GDPrank, eduDT, by = 'CountryCode')

mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]

library("quantmod")
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)
timeDT <- data.table::data.table(timeCol = sampleTimes)

# How many values were collected in 2012?
timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]
# Answer:
# 250

# How many values were collected on Mondays in 2012?
timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]



######################################################################

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url, destfile = "data.csv", method = "curl")
acs <- read.csv("data.csv")

agricultureLogical <- c(acs$ACR == 3, acs$AGS == 6)
head(which(agricultureLogical), 3)

######################################################################

library(jpeg)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url = url, destfile = "pic.jpg", mode = "wb")
pic <- readJPEG("pic.jpg", native = TRUE)

quantile(pic,  prob = seq(0, 1, length = 11))

######################################################################

library(data.table)

url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url1, destfile = "data_1.csv", method = "curl")
data_1 <- fread("data_1.csv",
                   skip = 4,
                   nrows = 190,
                   select = c(1, 2, 4, 5),
                   col.names = c("CountryCode", "Rank", "Economy", "Total"))

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url2, destfile = "data_2.csv", method = "curl")
data_2 <- read.csv("data_2.csv")

data <- merge(data_1, data_2, by = "CountryCode")

nrow(data)

arrange(data, desc(Rank))


######################################################################

tapply(data$'Rank', data$'Income.Group', mean)

######################################################################

