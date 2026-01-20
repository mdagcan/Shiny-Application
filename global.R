# Gerekli paketleri yükle
if(!require(shiny)) install.packages("shiny")
if(!require(plotly)) install.packages("plotly")
if(!require(DT)) install.packages("DT")

library(shiny)
library(plotly)
library(DT)

# AirQuality veri setini yükle
data(airquality)

# NA değerleri temizle
airquality_clean <- na.omit(airquality)

# Ay isimlerini ekle
airquality_clean$MonthName <- factor(months(as.Date(paste0("1973-", 
                                                         airquality_clean$Month, "-01"))),
                                   levels = c("May", "June", "July", "August", "September"))
