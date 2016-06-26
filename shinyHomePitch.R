# Coursera Data Science Specialization
# Building Data Products Course
# Housing Prices Time Series Forecasting
# John James
# Start Date: May 23, 2015

# shinyHomePitch

# Libraries
library(forecast)
library(ggplot2)
library(rCharts)
library(reshape)

# Get Time Series Data
hviAllCity  = read.csv("./processedData/hviAllCity.csv", header = TRUE, stringsAsFactors = FALSE)
d <- subset(hviAllCity, StateName == "California" & City == "San Francisco", select = X2000.01:X2015.12)
d <- d[,]/1000
v  <- as.numeric(as.vector(d))
d  <- ts(v, frequency = 12, start = c(2000,1))

#Train Models
ARIMA = auto.arima(d, ic='aicc', stepwise=FALSE)
ETS = ets(d, ic='aicc', restrict=FALSE)
NEURAL = nnetar(d, p=12, size=25)
TBATS = tbats(d, ic='aicc', seasonal.periods=12)
BATS = bats(d, ic='aicc', seasonal.periods=12)
STLM = stlm(d, s.window=12, ic='aicc', robust=TRUE, method='ets')
STS = StructTS(d, type = "level")
NAIVE = naive(d, 12)

# # Forecast
fcastARIMA   <-   forecast(ARIMA, 120)
fcastETS   <-   forecast(ETS, 120)
fcastNEURAL   <-   forecast(NEURAL, 120)
fcastTBATS   <-   forecast(TBATS, 120)
fcastBATS   <-   forecast(BATS, 120)
fcastSTLM   <-   forecast(STLM, 120)
fcastSTS   <-   forecast(STS, 120)
fcastNAIVE   <-   forecast(NAIVE, 120)

# Convert to numeric
fcastARIMA   <-   as.vector(as.numeric(fcastARIMA$mean))
fcastETS   <-   as.vector(as.numeric(fcastETS$mean))
fcastNEURAL   <-   as.vector(as.numeric(fcastNEURAL$mean))
fcastTBATS   <-   as.vector(as.numeric(fcastTBATS$mean))
fcastBATS   <-   as.vector(as.numeric(fcastBATS$mean))
fcastSTLM   <-   as.vector(as.numeric(fcastSTLM$mean))
fcastSTS   <-   as.vector(as.numeric(fcastSTS$mean))
fcastNAIVE   <-   as.vector(as.numeric(fcastNAIVE$mean))

timePeriod  <- seq.Date(as.Date('2016/1/1'), by = "month", length.out = 120) 
vars      <- c("TIME", "ARIMA", "ETS", "NAIVE", "NEURAL", "BATS", "TBATS", "STLM", "STS")
forecasts <- data.frame(timePeriod, fcastARIMA,	fcastETS,fcastNAIVE, fcastNEURAL, fcastBATS, fcastTBATS, fcastSTLM,	fcastSTS)
names(forecasts) <- vars
forecasts <- melt(forecasts, id = "TIME")
names(forecasts) <- c("Time", "Model", "Value")
print(head(forecasts))
print(unique(forecasts$Model))
# Plot Forecast
p <- nPlot(Value ~ Time, group = "Model", type = "lineChart", data = forecasts)
p$xAxis(
  tickFormat = 
    "#!
  function(d){
  f =  d3.time.format.utc('%Y-%m-%d');
  return f(new Date( d*24*60*60*1000 ));
  }
  !#"
)
p$yAxis(tickFormat = "#! function(d) {return d3.format(',.0f')(d)} !#")
p$yAxis(axisLabel = "($000)", width = 63)
print(p)
 
#Get end of period prediction
fcastARIMA  <- fcastARIMA[length(fcastARIMA)]
fcastETS  <- fcastETS[length(fcastETS)]
fcastNEURAL  <- fcastNEURAL[length(fcastNEURAL)]
fcastTBATS  <- fcastTBATS[length(fcastTBATS)]
fcastBATS  <- fcastBATS[length(fcastBATS)]
fcastSTLM  <- fcastSTLM[length(fcastSTLM)]
fcastSTS  <- fcastSTS[length(fcastSTS)]
fcastNAIVE  <- fcastNAIVE[length(fcastNAIVE)]

#Plot end of period.
prediction <- as.vector(c(fcastARIMA,	fcastETS,	fcastNAIVE, fcastNEURAL,	fcastBATS, fcastTBATS,	fcastSTLM,	fcastSTS))
models <- c("Arima", "ETS", "Naive", "Neural", "BATS", "TBATS", "STLM", "STS")
d <- data.frame(models, prediction)
colnames(d) <- c("Model","Prediction")
p <- nPlot(Prediction~Model, data = d, type = "discreteBarChart", dom = "predictionPlot", height = 400, width = 600)
p$set(title = "Predicted Median Home Values at End of Forecast Period")
p$xAxis(staggerLabels = TRUE)
p$yAxis(tickFormat = "#! function(d) {return d3.format(',.0f')(d)} !#")
p$yAxis(axisLabel = "($000)", width = 60)
print(p)
