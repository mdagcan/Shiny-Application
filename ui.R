shinyUI(fluidPage(
  
  # CSS stil dosyasını ekle
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  
  # Uygulama başlığı
  titlePanel("🌍 Air Quality Analysis Dashboard"),
  
  # Yan panel
  sidebarLayout(
    sidebarPanel(
      width = 3,
      
      # Grafik tipi seçimi
      radioButtons("graphType", 
                   "Select Graph Type:",
                   choices = list("Scatter Plot" = "scatter",
                                  "Line Chart" = "line",
                                  "Histogram" = "histogram",
                                  "Box Plot" = "boxplot"),
                   selected = "scatter"),
      
      # X ekseni değişkeni
      selectInput("xvar", 
                  "X-Axis Variable:",
                  choices = list("Solar Radiation" = "Solar.R",
                                 "Wind Speed" = "Wind",
                                 "Temperature" = "Temp",
                                 "Ozone Level" = "Ozone"),
                  selected = "Temp"),
      
      # Y ekseni değişkeni
      selectInput("yvar", 
                  "Y-Axis Variable:",
                  choices = list("Ozone Level" = "Ozone",
                                 "Solar Radiation" = "Solar.R",
                                 "Wind Speed" = "Wind",
                                 "Temperature" = "Temp"),
                  selected = "Ozone"),
      
      # Ay seçimi
      checkboxGroupInput("months",
                         "Select Months:",
                         choices = c("May", "June", "July", "August", "September"),
                         selected = c("May", "June", "July", "August", "September"),
                         inline = TRUE),
      
      # Renk paleti seçimi
      selectInput("colorPalette",
                  "Color Palette:",
                  choices = c("Set1", "Set2", "Set3", "Paired", "Dark2", "Accent"),
                  selected = "Set1"),
      
      # Trend çizgisi
      checkboxInput("trendLine", "Show Trend Line", value = TRUE),
      
      # Grafik başlığı
      textInput("graphTitle", "Graph Title:", 
                value = "Air Quality Analysis"),
      
      # Kayıt butonu
      actionButton("saveBtn", "📥 Save Plot as PNG", 
                   class = "btn-success"),
      
      # Bilgi paneli
      hr(),
      h4("ℹ️ Information"),
      verbatimTextOutput("infoText")
    ),
    
    # Ana panel
    mainPanel(
      width = 9,
      tabsetPanel(
        tabPanel("Visualization",
                 plotlyOutput("airPlot", height = "500px"),
                 h4("📊 Summary Statistics"),
                 verbatimTextOutput("summary")),
        
        tabPanel("Data Table",
                 DTOutput("dataTable"),
                 downloadButton("downloadData", "📥 Download CSV")),
        
        tabPanel("Correlation Matrix",
                 plotlyOutput("corrPlot", height = "500px")),
        
        tabPanel("Documentation",
                 includeMarkdown("documentation.md"))
      )
    )
  )
))
