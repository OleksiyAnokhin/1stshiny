#########################
######DC Crime ##########
#####Xiaowei Cheng#######
#########################


library(shiny)
library(shinythemes)
# library(ggplot2)
# library(data.table)
library(leaflet)
# library(googleVis)
# library(tidyverse)
library(shinydashboard)
# library(googleVis)
library(dplyr)


dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Washignton DC"),
  dashboardSidebar(
    sidebarUserPanel("Be Safe!",image = "https://washington.org/ddc_opengraph.png"),
    sidebarMenu(
      menuItem("Crime",
        menuSubItem("Shift",tabName = "shift"),
        menuSubItem("Crime Type",tabName = "crime_type"),
        menuSubItem("District",tabName = "district")),
      menuItem("Map",tabName = "map", badgeLabel = "COOL!", badgeColor = "green",icon = icon("globe")),
      menuItem("DENSITY MAP",tabName = "heat", badgeLabel = "HEAT!!!", badgeColor = "red", icon = icon("sun-o")),
      menuItem("WARNING",tabName = "warn", badgeLabel = "!!!", badgeColor = "yellow",icon = icon("ban")),
      menuItem("Holiday",tabName = "holiday", badgeLabel = "FUN", badgeColor = "maroon",icon = icon("flag")),
      menuItem("Conclusion",tabName = "rate", badgeLabel = "?!", badgeColor = "blue", icon = icon("commenting")),
      menuItem("Summarise",tabName = "sum"),
      menuItem("Info",tabName = "info", icon = icon("info"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabItems(
      
      tabItem(tabName = "shift",
        selectizeInput("year", "Select Year", 
                       c(2012, 2013, 2014, 2015, 2016, 2017), 
                       selected = 2012),
              plotOutput("plotshift")),
      tabItem(tabName = "crime_type",
              h2("Crime"),
              fluidRow(
                box(selectizeInput("year1","Select Year", 
                               c(2012,2013,2014,2015,2016,2017), 
                               selected = 2012)),
                plotOutput("plotcrime")
                )),
      tabItem(tabName = "district",
              selectizeInput("year2","Select Year",
                             c(2012,2013,2014,2015,2016,2017),
                             selected = 2012),
              plotOutput("plotdistrict"),
              br(),
              fluidRow(img(src='districtmap.jpg'))
              ),
      tabItem(tabName = "map",
          h2("Mapping"),
          selectizeInput("type","Select Crime Type",
                         c(ALL = "ALL",choice)),
          leafletOutput("total",width = 500,height = 500)),
      tabItem(tabName = "heat",
              h2("Density MAP"),
              selectizeInput("hot","Select Crime Type",
                             c(ALL = "ALL",choice)),
              leafletOutput("heatmap")),
      tabItem(tabName = "warn",
          h2("Red Zone"),
          selectizeInput("zone","Select Crime Type",
                         choice),
          leafletOutput("rplocation")),
      tabItem(tabName = "holiday",
          h2("Should We Enjoy the Holidays?"),
          htmlOutput("Scatter"),
          h4("Percentage: 2012:0.85%
                          2013:0.85%
                          2014:0.94%
                          2015:0.90%
                          2016:0.86%")),
      tabItem(tabName = "rate",
          h2("Let's Check on the Comparison"),
          htmlOutput("Scatter1"),
          h4("Total Change: 2013:+1.5% 2014:+7% 2015:-3% 2016:-0.2%")),
      tabItem(tabName = "sum",
              h2("Summary"),
              h4("1.District is importatnt!"),
              h4("2.Enjoy your holiday!"),
              h4("3.Protect yourself is alwasy important.")),
      tabItem(tabName = "info",
          h4("Data Source: http://opendata.dc.gov/"),
          h4("Newest Data Record Date: 2017/07/13"),
          h4("Holiday Definition: New Year,Independence Day,Thanksgiving,Christmas"),
          h4("Author: Xiaowei Cheng"),
          h4("Email: xiaoweicheng@myself.com"))
    )
  )
)