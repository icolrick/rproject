
######################################################################
#0 load packages
library(httr)
require(httpuv)
require(jsonlite)

#1 find gh settings
settings <- oauth_endpoints("github")
settings

#2 applicaton specs
app <- oauth_app("Leek_Repo",
                 key = "3dd638be857e15dbae0c",
                 secret = "96bb15e584290ea17bae6565df83df5cbd71b8d4")

#3 get credentails
git_token <- oauth2.0_token(settings, app)

#4 use api
gtoken <- config(token = git_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
result <- content(req)


#5 convert data
json <- fromJSON(toJSON(result))
subset(json, name == "datasharing", select = c(created_at))

######################################################################

library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = url, destfile = "data.csv", method = "curl")
acs <- read.csv("data.csv")

# sqldf("select * from acs")
# sqldf("select pwgtp1 from acs where AGEP \lt< 50")
# sqldf("select pwgtp1 from acs")
sqldf("select * from acs where AGEP \lt< 50") # <- there it is!

######################################################################

sqldf("select distinct AGEP from acs")

######################################################################

url <- "http://biostat.jhsph.edu/~jleek/contact.html"
readUrl <- readLines(url)

nchar(readUrl[10])
nchar(readUrl[20])
nchar(readUrl[30])
nchar(readUrl[100])

######################################################################

library(readr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
data <- read_fwf(url,
                 fwf_widths(c(12, 7, 4,
                              9, 4, 9, 4, 9, 4)),
                 skip = 4)

result <- sum(data[, 4])
result




