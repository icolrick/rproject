setwd("/Users/iancolrick/rproject/exploratory analysis/assignment 2")
library(dplyr)
library(ggplot2)

data_1 <- readRDS(("summarySCC_PM25.rds"))
data_1 <- tbl_df(data_1)
data_2 <- readRDS(("Source_Classification_Code.rds"))
data_2 <- tbl_df(data_2)

colors <- c("red", "blue", "green", "yellow")

                                        #Question 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999 , 2002, 2005, and 2008.

png("graph1.png",width = 480, height = 480)
agg_emissions <- summarise(group_by(data_1, year), "EmissionsSum" = sum(Emissions))
barplot(height = agg_emissions$EmissionsSum, names.arg = agg_emissions$year, xlab = "Years", ylab = "Total emissions from PM2.5 in kilotons", main = "Total emissions from PM2.5 in US\n from 1999 to 2008", col = colors)

                                        # Question 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

png("graph2.png", width = 480, height = 480)
balt_agg_emissions <-  summarise(group_by(filter(data_1, fips == "24510"), year), "EmissionsSum" = sum(Emissions))
barplot(height = balt_agg_emissions$EmissionsSum, names.arg = balt_agg_emissions$year, xlab = "Years", ylab = "Total emissions from PM2.5 in kilotons", main = "Total emissions from PM2.5 in Baltimore, MD\n from 1999 to 2008", col = colors)

                                        #Question 3
# Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

png("graph3.png")
balt_agg_emissions_bytype <-  summarise(group_by(filter(data_1, fips == "24510"), year, type), "EmissionsSum" = sum(Emissions))


g <- ggplot(balt_agg_emissions_bytype, aes(factor(year), EmissionsSum, fill = type), label = round(EmissionsSum, 0)) + geom_point() +
    geom_bar(position = 'dodge', stat = 'identity') +
    geom_text(aes(label = EmissionsSum), position = position_dodge(width=0.9), vjust = -0.25) +
    facet_grid(. ~ type) +
    labs(title = "Aggregate emissions by type in Baltimore City\n from 1999 to 2008", x = "Year", y = "Total    PM 2.5 emissions in kilotons", hadjust = .5)

print(g)

                                        #Question 4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

png("graph4.png")


q4 <- tbl_df(merge(data_1, data_2, by = "SCC"))


graph4 <-
    q4 %>%
    select(year, type, Emissions, Short.Name) %>%
    mutate(coal = grepl("coal", Short.Name, ignore.case = TRUE)) %>%
    filter(coal == TRUE) %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))


g <- ggplot(graph4, aes(year, Emissions)) +
             geom_bar(stat = "identity", col = state) +
             labs(title = "Aggregate emissions from coal combustion related sources",
                   subtitle = "Across the United States",
                   x = "Years",
                  y = "Emissions in PM2.5")

print(g)



                                        #Question 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

png("graph5.png")

q5 <- tbl_df(data_1)


graph5 <-
    q5 %>%
    select(year, type, Emissions, fips) %>%
    filter(type == 'ON-ROAD', fips == '24510') %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))


g <- ggplot(graph5, aes(year, Emissions)) +
             geom_bar(stat = "identity", aes(fill = year)) +
             labs(title = "Aggregate emissions from mobile vehicle related sources",
                   subtitle = "In Baltimore City",
                   x = "Years",
                  y = "Emissions in PM2.5")

print(g)

                                        #Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greaterchanges over time in motor vehicle emissions?

png("graph6.png")

q6 <- tbl_df(data_1)



graph6.1 <-
    q6 %>%
    select(year, type, Emissions, fips) %>%
    filter(type == 'ON-ROAD', fips == '24510') %>%
    group_by(year, fips = "Baltimore") %>%
    summarise(Emissions = sum(Emissions))

graph6.2 <-
    q6 %>%
    select(year, type, Emissions, fips) %>%
    filter(type == 'ON-ROAD', fips == '06037') %>%
    group_by(year, fips = "Los Angeles") %>%
    summarise(Emissions = sum(Emissions))


graph6 <- rbind(graph6.1, graph6.2)


g <- ggplot(graph6, aes(year, Emissions)) +
             geom_bar(stat = "identity", aes(fill = year)) +
             facet_grid(. ~ fips) +
             labs(title = "Aggregate emissions from mobile vehicle related sources",
                   subtitle = "In Baltimore City vs Los Angeles",
                   x = "Years",
                  y = "Emissions in PM2.5")

print(g)
