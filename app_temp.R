# Load R packages
library(shiny)
library(shinythemes)
if(!require(shinyWidgets)) install.packages("shinyWidgets", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")
if(!require(RColorBrewer)) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")
if(!require(leaflet)) install.packages("leaflet", repos = "http://cran.us.r-project.org")
if(!require(maps)) install.packages("maps", repos = "http://cran.us.r-project.org")
if(!require(ggplot2)) install.packages("ggplot2", repos = "http://cran.us.r-project.org")

  # Define UI
  ui <- fluidPage(theme = shinytheme("superhero"),
    navbarPage(
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "Texas COVID Vaccine Tracker",
      tabPanel("Mapper",
               sidebarPanel(
                 tags$h3("County"),
                 textInput("txt1", "Input a valid county name here:", "Dallas"),

               ), # sidebarPanel
               mainPanel(
                            h1("Header 1"),
                            
                            h4("Output 1"),
                            verbatimTextOutput("txtout"),

               ) # mainPanel
               
      ), # Navbar 1, tabPanel
      tabPanel("Navbar 2", "This panel is intentionally left blank"),
      tabPanel("Navbar 3", "This panel is intentionally left blank")
  
    ) # navbarPage
  ) # fluidPage

  
  ui2 <- bootstrapPage(
    #tags$head(includeHTML("gtag.html")),
    navbarPage(theme = shinytheme("flatly"), collapsible = TRUE,
               HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">COVID-19 vaccine tracker</a>'), id="nav",
               windowTitle = "COVID-19 vaccine tracker",
               tabPanel("COVID-19 mapper",
                        div(class="outer",
                            tags$head(includeCSS("styles.css")),
                            leafletOutput("mymap", width="100%", height="100%"),
                            
                            absolutePanel(id = "controls", class = "panel panel-default",
                                          top = 75, left = 55, width = 250, fixed=TRUE,
                                          draggable = TRUE, height = "auto",
                                          
                                          span(tags$i(h6("Reported cases are subject to significant variation in testing policy and capacity between countries.")), style="color:#045a8d"),
                                          h3(textOutput("reactive_case_count"), align = "right"),
                                          h4(textOutput("reactive_death_count"), align = "right"),
                                          h6(textOutput("clean_date_reactive"), align = "right"),
                                          h6(textOutput("reactive_country_count"), align = "right"),
                                          plotOutput("epi_curve", height="130px", width="100%"),
                                          plotOutput("cumulative_plot", height="130px", width="100%"),
                                          
                                          
                                          
                            ),
                            
                            absolutePanel(id = "logo", class = "card", bottom = 20, left = 60, width = 80, fixed=TRUE, draggable = FALSE, height = "auto",
                                          tags$a(href='https://www.lshtm.ac.uk', tags$img(src='lshtm_dark.png',height='40',width='80'))),
                            
                            absolutePanel(id = "logo", class = "card", bottom = 20, left = 20, width = 30, fixed=TRUE, draggable = FALSE, height = "auto",
                                          actionButton("twitter_share", label = "", icon = icon("twitter"),style='padding:5px',
                                                       onclick = sprintf("window.open('%s')", 
                                                                         "https://twitter.com/intent/tweet?text=%20@LSHTM_Vaccines%20outbreak%20mapper&url=https://bit.ly/2uBvnds&hashtags=coronavirus")))
                            
                            
                        )
               ),
               tabPanel("County plots",
                        
                        
                        ),
               
               tabPanel("Data",
                        numericInput("maxrows", "Rows to show", 25),
                        verbatimTextOutput("rawtable"),
                        downloadButton("downloadCsv", "Download as CSV"),tags$br(),tags$br(),
                        "Adapted from timeline data published by ", tags$a(href="INSERT LINK :)", 
                                                                           "<insert source here>")
               ),
               tabPanel("About this site",
                        tags$div(
                          tags$h4("Last update"), 
                          #h6(paste0(update)),
                          "This site is updated once a week. There are several other excellent vaccine tracking tools available, including those run by", 
                          tags$a(href="https://www.bloomberg.com/graphics/covid-vaccine-tracker-global-distribution/", "Bloomberg"),
                          
                          "Our aim is to complement these resources with several interactive features as well as visualization of data detailing pharmacy locations vaccine dosage allotments.",
                          
                          tags$br(),tags$br(),tags$h4("Background"), 
                          "TODO,",
                          tags$br(),tags$br(),
                          "TODO",
                          tags$br(),tags$br(),
                          tags$br(),tags$br(),tags$h4("Sources"),
                          tags$b("Texas vaccination statistics"), tags$a(href="https://tabexternal.dshs.texas.gov/t/THD/views/COVID-19VaccineinTexasDashboard/Summary?%3Aorigin=card_share_link&%3Aembed=y&%3AisGuestRedirectFromVizportal=y", "the Texas DHS"),
                          tags$b("Weekly vaccine allocation reports: "), tags$a(href="https://www.dshs.texas.gov/coronavirus/immunize/vaccine.aspx", "the Texas DHS"),
                          tags$br(),tags$br(),tags$h4("Authors"),
                          "Nicolas Jacobs, student at The University of Toronto",tags$br(),
                          "Hanad Hassan, student at The University of Toronto",tags$br(),
                          tags$br(),tags$br(),tags$h4("Contact"),
                          "nicolas.jacobs@utoronto.ca",tags$br(),tags$br(),
                    
                        )
               )
           )
  )
  
  
  
  # Define server function  
  server <- function(input, output) {
    
    output$txtout <- renderText({
      paste( input$txt1, input$txt2, sep = " " )
    })
  } # server
  

  # Create Shiny object
  shinyApp(ui = ui2, server = server)
