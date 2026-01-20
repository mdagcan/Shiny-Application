# 🌍 Air Quality Analysis Dashboard - Documentation

## 📖 Overview
This Shiny application analyzes the AirQuality dataset from R, which contains daily air quality measurements in New York from May to September 1973.

## 🎯 Features
1. **Interactive Visualization**: Four types of plots (Scatter, Line, Histogram, Boxplot)
2. **Dynamic Filtering**: Filter data by months
3. **Correlation Analysis**: View relationships between variables
4. **Data Export**: Download filtered data as CSV
5. **Customization**: Adjust colors, titles, and display options

## 📊 Variables
- **Ozone**: Ozone level in parts per billion (ppb)
- **Solar.R**: Solar radiation in Langleys
- **Wind**: Average wind speed in miles per hour (mph)
- **Temp**: Maximum daily temperature in degrees Fahrenheit (°F)
- **Month**: Month of measurement (5=May to 9=September)
- **Day**: Day of the month

## 🚀 How to Use
1. **Select Graph Type**: Choose from 4 visualization types
2. **Choose Variables**: Select X and Y axis variables
3. **Filter Months**: Select specific months to analyze
4. **Customize**: Adjust colors and display options
5. **Explore**: View statistics and correlations

## 💡 Tips
- Use scatter plots to see relationships between two variables
- Line charts show trends over time
- Histograms display distribution of a single variable
- Box plots compare distributions across months
- Hover over points to see detailed information

## 🔧 Technical Details
- Built with R Shiny
- Uses Plotly for interactive graphics
- Responsive design for all screen sizes
- Real-time data processing
