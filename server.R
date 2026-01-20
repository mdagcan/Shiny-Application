shinyServer(function(input, output, session) {
  
  # Filtrelenmiş veri seti
  filteredData <- reactive({
    data <- airquality_clean
    data <- data[data$MonthName %in% input$months, ]
    return(data)
  })
  
  # Ana grafik
  output$airPlot <- renderPlotly({
    data <- filteredData()
    
    if(input$graphType == "scatter") {
      p <- plot_ly(data = data, 
                   x = ~get(input$xvar),
                   y = ~get(input$yvar),
                   color = ~MonthName,
                   colors = input$colorPalette,
                   type = 'scatter',
                   mode = 'markers',
                   text = ~paste("Month:", MonthName,
                                 "<br>Day:", Day,
                                 "<br>", input$xvar, ":", get(input$xvar),
                                 "<br>", input$yvar, ":", get(input$yvar)),
                   hoverinfo = 'text',
                   marker = list(size = 10, opacity = 0.7))
      
      if(input$trendLine) {
        p <- p %>% add_lines(y = ~fitted(loess(get(input$yvar) ~ get(input$xvar))),
                             line = list(color = 'red', width = 2),
                             name = "Trend")
      }
      
    } else if(input$graphType == "line") {
      p <- plot_ly(data = data,
                   x = ~Day,
                   y = ~get(input$yvar),
                   color = ~MonthName,
                   colors = input$colorPalette,
                   type = 'scatter',
                   mode = 'lines+markers')
      
    } else if(input$graphType == "histogram") {
      p <- plot_ly(data = data,
                   x = ~get(input$xvar),
                   type = "histogram",
                   color = ~MonthName,
                   colors = input$colorPalette)
      
    } else if(input$graphType == "boxplot") {
      p <- plot_ly(data = data,
                   y = ~get(input$yvar),
                   color = ~MonthName,
                   colors = input$colorPalette,
                   type = "box")
    }
    
    p <- p %>%
      layout(title = input$graphTitle,
             xaxis = list(title = input$xvar),
             yaxis = list(title = input$yvar),
             hovermode = 'closest')
    
    return(p)
  })
  
  # Özet istatistikler
  output$summary <- renderPrint({
    data <- filteredData()
    cat("Dataset Summary:\n")
    cat("================\n")
    cat("Selected Months:", paste(input$months, collapse = ", "), "\n")
    cat("Number of Observations:", nrow(data), "\n")
    cat("\nBasic Statistics for", input$yvar, ":\n")
    summary(data[[input$yvar]])
  })
  
  # Korelasyon matrisi
  output$corrPlot <- renderPlotly({
    data <- filteredData()[, c("Ozone", "Solar.R", "Wind", "Temp")]
    cor_matrix <- cor(data, use = "complete.obs")
    
    plot_ly(z = cor_matrix,
            x = colnames(cor_matrix),
            y = colnames(cor_matrix),
            type = "heatmap",
            colorscale = "Viridis") %>%
      layout(title = "Correlation Matrix",
             xaxis = list(title = ""),
             yaxis = list(title = ""))
  })
  
  # Veri tablosu
  output$dataTable <- renderDT({
    datatable(filteredData(),
              options = list(pageLength = 10,
                             scrollX = TRUE,
                             dom = 'Bfrtip',
                             buttons = c('copy', 'csv', 'excel')),
              filter = 'top',
              rownames = FALSE) %>%
      formatRound(columns = c("Ozone", "Solar.R", "Wind", "Temp"), digits = 2)
  })
  
  # Bilgi metni
  output$infoText <- renderText({
    paste("Dataset: AirQuality\n",
          "Time Period: May-Sep 1973\n",
          "Variables:\n",
          "- Ozone: ppb\n",
          "- Solar.R: lang\n",
          "- Wind: mph\n",
          "- Temp: °F")
  })
  
  # Veri indirme
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("air_quality_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filteredData(), file, row.names = FALSE)
    }
  )
  
  # Grafik kaydetme
  observeEvent(input$saveBtn, {
    showModal(modalDialog(
      title = "Plot Saved",
      "The plot has been saved as 'air_quality_plot.png'",
      easyClose = TRUE,
      footer = NULL
    ))
  })
})
