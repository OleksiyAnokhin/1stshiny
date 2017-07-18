#########################
######DC Crime ##########
#####Xiaowei Cheng#######
#########################

library(shiny)
library(shinythemes)
library(ggplot2)
library(data.table)
library(leaflet)
library(googleVis)
library(tidyverse)
library(shinydashboard)
library(googleVis)
library(dplyr)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  reactthis <- reactive({
    count_shift %>% 
      filter(year == input$year)
  })
  output$plotshift <- renderPlot({
    ggplot(data = reactthis(), aes(x = SHIFT, y = count, fill = SHIFT)) + 
      geom_bar(stat = 'identity') + 
      guides(fill = F) + 
      labs(x = 'Shift', y = 'Total Number of Crimes', title = 'Total Number of Crimes per Shift')
  })
  reactcrime <- reactive({
    count_crime %>% 
      filter(year == input$year1)
  })
  output$plotcrime <- renderPlot({
      ggplot(reactcrime(), aes(x = CRIME, y = count, fill = CRIME)) + 
        geom_bar(stat = 'identity') +  
        theme(axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank()) +
        labs(x = '', y = 'Total Number of Crimes', title = 'Total Count of Crimes per Category')
  })
  reactdistrict <- reactive({
    count_district %>% 
      filter(year == input$year2)
  })
  output$plotdistrict <- renderPlot({
    ggplot(reactdistrict(),aes(x = DISTRICT, y = count, fill = DISTRICT)) + 
      geom_bar(stat = 'identity') +
      guides(fill = F) +
      labs(x = 'District', y = 'Total Number of Crimes', title = 'Total Number of Crimes per District')
  })
  output$rplocation <- renderLeaflet({
    rpt_locs <- data %>% 
      filter(CRIME == input$zone) %>% 
      group_by(LONGITUDE, LATITUDE,DISTRICT,BLOCK) %>%
      summarise(n = n()) %>%
      ungroup() %>%
      arrange(desc(n)) %>% 
      slice(1:10)
    popup <- paste0("<strong>Frequency: </strong>", rpt_locs$n,
                    "<br><strong>Location: </strong>", rpt_locs$BLOCK,
                    "<br><strong>Borough: </strong>", rpt_locs$DISTRICT)
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>% 
      addCircleMarkers(data = rpt_locs,
                       ~LONGITUDE, ~LATITUDE, 
                       fillColor = "white", color = "red",  
                       radius = ~n*0.1, 
                       popup = ~popup) %>% 
      setView(-76.99952,38.90192,zoom = 12)
    })
  output$total <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      setView(-76.99952,38.90192,zoom = 11)
  })
  
  observe({
      proxy <- leafletProxy("total") %>% 
        clearMarkers() %>% 
        clearMarkerClusters() %>% 
        addCircleMarkers(data = data %>% 
                           filter_(ifelse(input$type == "ALL",TRUE,"`CRIME` == input$type")),
                           clusterOptions = markerClusterOptions(), 
                           ~LONGITUDE,~LATITUDE, popup="Washington DC",color = 'Red',radius = 1)
    })

  output$heatmap <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(providers$CartoDB.DarkMatter) %>% 
      setView(-76.99952,38.90192,zoom = 11)
  })
  
  observe({
    proxy <- leafletProxy("heatmap") %>% 
      removeWebGLHeatmap(layerId = 'a') %>% 
      addWebGLHeatmap(layerId = 'a',data = data %>% filter_(ifelse(input$hot == "ALL",TRUE,"`CRIME` == input$hot")), lng=~LONGITUDE, lat=~LATITUDE, size = 200)
      
  })
  
  output$Scatter <- renderGvis({
    gvisScatterChart(count_hohoholiday, 
                                options=list(
                                  legend="none",
                                  lineWidth=2, pointSize=6,
                                  title="Holidays",
                                  width=600, height=600))

  })
  output$Scatter1 <- renderGvis({
    gvisScatterChart(total_crime,
                     options = list(
                       legend="none",
                       lineWidth=2, pointSize=5,
                       title="ALL TOTAL",
                       width=600,height=600))
  })
})