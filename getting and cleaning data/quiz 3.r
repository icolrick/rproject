

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

