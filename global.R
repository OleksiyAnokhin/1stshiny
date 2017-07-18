
# library(shiny)
# library(shinythemes)
# library(ggplot2)
# library(data.table)
# library(leaflet)
# library(googleVis)
# library(tidyverse)
# library(shinydashboard)
# library(googleVis)
library(leaflet.extras)
library(dplyr)


# o12 <- fread("/Users/xiaoweicheng/Desktop/XiaoweiChengShiny/Crime_Incidents_in_2012.csv")
# o13 <- fread("/Users/xiaoweicheng/Desktop/XiaoweiChengShiny/Crime_Incidents_in_2013.csv")
# o14 <- fread("/Users/xiaoweicheng/Desktop/XiaoweiChengShiny/Crime_Incidents_in_2014.csv")
# o15 <- fread("/Users/xiaoweicheng/Desktop/XiaoweiChengShiny/Crime_Incidents_in_2015.csv")
# o16 <- fread("/Users/xiaoweicheng/Desktop/XiaoweiChengShiny/Crime_Incidents_in_2016.csv")
# o17 <- fread("/Users/xiaoweicheng/Desktop/XiaoweiChengShiny/Crime_Incidents_in_2017.csv")
# raw <- rbind(o12,o13,o14,o15,o16,o17)
# data <- raw %>% select(-X,-Y,-XBLOCK,-YBLOCK,-WARD,-ANC,-PSA,-NEIGHBORHOOD_CLUSTER,-CENSUS_TRACT,-VOTING_PRECINCT,-XCOORD,-YCOORD,-BID,-OBJECTID)
# 
# 
# data$REPORT_DAT <- substr(data$REPORT_DAT,0,10)
# data <- data %>% mutate(REPORT_DAT = as.Date(REPORT_DAT, "%Y-%m-%d"))
# data <- data %>% mutate(month=as.numeric(format(REPORT_DAT, "%m")))
# data <- data %>% mutate(year=as.numeric(format(REPORT_DAT, "%Y")))
# data <- data %>% mutate(day=as.numeric(format(REPORT_DAT, "%d")))
# 
# 
# data$DISTRICT <- gsub("1","First District Station",data$DISTRICT)
# data$DISTRICT <- gsub("2","Second District Station",data$DISTRICT)
# data$DISTRICT <- gsub("3","Third District Station",data$DISTRICT)
# data$DISTRICT <- gsub("4","Fourth District Station",data$DISTRICT)
# data$DISTRICT <- gsub("5","Fifth District Station",data$DISTRICT)
# data$DISTRICT <- gsub("6","Sixth District Station",data$DISTRICT)
# data$DISTRICT <- gsub("7","Seventh District Station",data$DISTRICT)
# data <- rename(data, CRIME = OFFENSE)
# data$CRIME <- gsub("ASSAULT W/DANGEROUS WEAPON","ASSAULT",data$CRIME)
# data <- data[complete.cases(data), ]


# holiday <- data %>% filter(REPORT_DAT == "2012-01-01"|
#                              REPORT_DAT == "2013-01-01"|
#                              REPORT_DAT == "2014-01-01"|
#                              REPORT_DAT == "2015-01-01"|
#                              REPORT_DAT == "2016-01-01"|
#                              REPORT_DAT == "2017-01-01"|
#                              REPORT_DAT == "2012-07-04"|
#                              REPORT_DAT == "2013-07-04"|
#                              REPORT_DAT == "2014-07-04"|
#                              REPORT_DAT == "2015-07-04"|
#                              REPORT_DAT == "2016-07-04"|
#                              REPORT_DAT == "2017-07-04"|
#                              REPORT_DAT == "2012-11-23"|
#                              REPORT_DAT == "2013-11-23"|
#                              REPORT_DAT == "2014-11-23"|
#                              REPORT_DAT == "2015-11-23"|
#                              REPORT_DAT == "2016-11-23"|
#                              REPORT_DAT == "2017-11-23"|
#                              REPORT_DAT == "2012-12-25"|
#                              REPORT_DAT == "2013-12-25"|
#                              REPORT_DAT == "2014-12-25"|
#                              REPORT_DAT == "2015-12-25"|
#                              REPORT_DAT == "2016-12-25"|
#                              REPORT_DAT == "2017-12-25")
data <- readRDS("data.rds")
holiday <- readRDS("holiday.rds")
count_holiday <- holiday %>% group_by(REPORT_DAT,CRIME) %>% summarise(count = n())
count_holidaytotal <- holiday %>% group_by(REPORT_DAT) %>% summarise(count = n())
count_hohoholiday <- holiday %>% group_by(year) %>% summarise(count = n())
count_crime <- data %>% group_by(year,CRIME) %>% summarise(count = n())
count_shift <- data %>%  group_by(year,SHIFT) %>% summarise(count = n())
count_shift$count <- as.numeric(count_shift$count)
count_crime$count <- as.numeric(count_crime$count)
count_district <- data %>% group_by(year,DISTRICT) %>% summarise(count = n())
choice <- unique(count_crime$CRIME)
total_crime <- data %>% group_by(year) %>% summarise(total = n())
total_crime$count <- as.numeric(total_crime$total)
# 
# data <- sample(data)
# saveRDS(holiday, file = "holiday.rds")
# saveRDS(data, file="data.rds")

