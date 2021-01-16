# Load R packages
library(tidyverse)
library(shiny)
library(shinythemes)
if(!require(shinyWidgets)) install.packages("shinyWidgets", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")
if(!require(RColorBrewer)) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")
if(!require(leaflet)) install.packages("leaflet", repos = "http://cran.us.r-project.org")
if(!require(maps)) install.packages("maps", repos = "http://cran.us.r-project.org")
if(!require(ggplot2)) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
library(tigris)
library(sf)
library(raster)
library(rgeos)
library(mapview)
library(maptools)
library(sp)
library(maps)
library(dplyr)
library(DT)
library(leaflet.extras)

# data imports

tx_data_g = read_csv("new_aggregate.csv")

  ui <- bootstrapPage(
    #tags$head(includeHTML("gtag.html")),
    navbarPage(theme = shinytheme("flatly"), collapsible = TRUE,
               HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">Texas Vaccine Tracker</a>'), id="nav",
               windowTitle = "COVID-19 Vaccine Tracker",
               tabPanel("Map",
                        div(class="outer",
                            tags$head(includeCSS("styles.css")),
                            leafletOutput("mymap", width="100%", height="100%"),
                            
                            
                            
                            absolutePanel(id = "logo", class = "card", bottom = 20, left = 60, width = 80, fixed=TRUE, draggable = FALSE, height = "auto",
                                          tags$a(href='https://www.lshtm.ac.uk', tags$img(src='lshtm_dark.png',height='40',width='80'))),
                            
                            absolutePanel(id = "logo", class = "card", bottom = 20, left = 20, width = 30, fixed=TRUE, draggable = FALSE, height = "auto",
                                          actionButton("twitter_share", label = "", icon = icon("twitter"),style='padding:5px',
                                                       onclick = sprintf("window.open('%s')", 
                                                                         "https://twitter.com/intent/tweet?text=%20@LSHTM_Vaccines%20outbreak%20mapper&url=https://bit.ly/2uBvnds&hashtags=coronavirus")))
                            
                            
                        )
               ),
               tabPanel("County Analysis",
                        
                        
                        ),
               
               tabPanel("Data",
                        numericInput("maxrows", "Rows to show", 25),
                        verbatimTextOutput("rawtable"),
                        downloadButton("downloadCsv", "Download as CSV"),tags$br(),tags$br(),
                        "Adapted from data published by the", tags$a(href="https://www.dshs.texas.gov/coronavirus/immunize/vaccine.aspx", 
                                                                  "Texas Health and Human Services")
               ),
               tabPanel("About",
                        tags$div(
                          tags$h4("Last update"), 
                          #h6(paste0(update)),
                          "This site is updated once a week. There are several other excellent vaccine tracking tools available, including those run by", 
                          tags$a(href="https://www.bloomberg.com/graphics/covid-vaccine-tracker-global-distribution/", "Bloomberg"),
                          
                          "Our aim is to complement these resources with several interactive features as well as visualization of data detailing pharmacy locations vaccine dosage allotments.",
                          
                          tags$br(),tags$br(),tags$h4("Background"), 
                          "We intend on making this web application available to the general populace, giving them the ability to easily locate the nearest location offering vaccines, with the given weekly vaccine allotment and previous weekly data, along with aggregate weekly allotment data.
                          This dataset was created to give users the ability to examine Texas' COVID vaccine allotment progress, which is an ongoing process. The data will be updated on a weekly basis, and aggregated in the aggregate.csv file. New data is provided once weekly, on Tuesday, by the Texas DSHS and converted from PDF to .csv",
                          tags$br(),tags$br(),
                          "This dataset was created to give users the ability to examine Texas' COVID vaccine allotment progress, which is an ongoing process. The data will be updated on a weekly basis, and aggregated in the *aggregate.csv* file. Data is aggregated from data published by the Texas DSHS. 
                          The raw data, published in .pdf format, is available from the raw folder.",
                          tags$br(),tags$br(),
                          tags$br(),tags$br(),tags$h4("Sources"),
                          tags$b("Texas vaccination statistics"), tags$a(href="https://tabexternal.dshs.texas.gov/t/THD/views/COVID-19VaccineinTexasDashboard/Summary?%3Aorigin=card_share_link&%3Aembed=y&%3AisGuestRedirectFromVizportal=y", "the Texas DSHS homepage"),
                          tags$b("weekly vaccine allocation reports: "), tags$a(href="https://www.dshs.texas.gov/coronavirus/immunize/vaccine.aspx", "the Texas DSHS"),
                          tags$br(),tags$br(),tags$h4("Authors"),
                          "Nicolas Jacobs, University of Toronto",tags$br(),
                          "Hanad Hassan, University of Toronto",tags$br(),
                          tags$br(),tags$br(),tags$h4("Contact"),
                          tags$a(href="https://www.nicojacgo.com", "Nicolas Jacobs"),tags$br(),tags$br(),
                          tags$a(href="https://www.hanadhassan.com", "Hanad Hassan"),tags$br(),tags$br()
                    
                        )
               )
           )
  )
  
  
  
  # Define server function  
  server <- function(input, output) {
    tx_data <- read_csv("new_aggregate.csv")
    #data.frame(test2)
    tx_data <- data.frame(tx_data)
    colnames(tx_data)
    colnames(tx_data)[colnames(tx_data) == 'lat'] <- 'Latitude'
    colnames(tx_data)[colnames(tx_data) == 'lon'] <- 'Longitude' 
    colnames(tx_data)
    tx_data$Latitude <- as.numeric(tx_data$Latitude)
    tx_data$Longitude <- as.numeric(tx_data$Longitude)
    tx_data = filter(tx_data, Latitude != "NA")
    pal <- colorFactor(pal = c("#1b9e77", "#d95f02", "#7570b3"), domain = c("Charity", "Government", "Private"))
    tx_data <- mutate(tx_data, cntnt=paste0('<strong>Provider Name: </strong>',Provider_Name,
                                            '<br><strong>Address:</strong> ', Address,
                                            '<br><strong>City:</strong> ', City,
                                            '<br><strong>County:</strong> ',County,
                                            '<br><strong>Doses (Week 5):</strong> ',Doses_W5,
                                            '<br><strong>Total:</strong> ',Sum)) 
    output$mymap <- renderLeaflet({
      leaflet(tx_data) %>%
        #addCircles(lng = ~Longitude, lat = ~Latitude) %>% 
        leaflet.extras::addSearchOSM(options = searchOptions(collapsed = FALSE)) %>%
        addTiles() %>%
        addCircleMarkers(data = tx_data, lat =  ~Latitude, lng =~Longitude, 
                         radius = 7.5, popup = ~as.character(cntnt), clusterOptions = markerClusterOptions(),
                         color = "red",
                         stroke = FALSE, fillOpacity = 0.8)%>%
        addLegend(pal=pal, values=tx_data$SumDosesRecd,opacity=1, na.label = "Not Available")%>%
        addEasyButton(easyButton(
          icon="fa-crosshairs", title="ME",
          onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
        
      
      
    })
    output$txtout <- renderText({
      paste( input$txt1, input$txt2, sep = " " )
    })
    
    output$downloadCsv <- downloadHandler(
      filename = function() {
        paste("COVID_Vaccine_Data_TX.csv", sep="")
      },
      content = function(file) {
        tx_data_sub = tx_data %>% dplyr::select(c(Provider_Name, Address, City, County, Doses_W1, Doses_W2, Doses_W3,
                                                  Doses_W4, Doses_W5, Sum))
        names(tx_data_sub) = c("Provider", "Address", "City", "County", "Doses_W1","Doses_W2","Doses_W3", "Doses_W4", 
                               "Doses_W5", "Total" )
        write.csv(tx_data_sub, file)
      }
    )
    
    output$rawtable <- renderPrint({
      tx_data_sub = tx_data %>% dplyr::select(c(Provider_Name, Address, City, County, Doses_W1, Doses_W2, Doses_W3,
                                                Doses_W4, Doses_W5, Sum))
      names(tx_data_sub) = c("Provider", "Address", "City", "County", "Doses_W1","Doses_W2","Doses_W3", "Doses_W4", 
                             "Doses_W5", "Total" )
      orig <- options(width = 1000)
      print(tail(tx_data_sub, input$maxrows), row.names = FALSE)
      options(orig)
    })
    
  } # server
  
  # Create Shiny object
  shinyApp(ui = ui, server = server)
