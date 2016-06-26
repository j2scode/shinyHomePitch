# Coursera Data Science Specialization
# Building Data Products Course
# Housing Prices Time Series Forecasting
# John James
# Start Date: May 23, 2015

# shinyHomePitch
## ---- environment
# Libraries
library(forecast)
library(ggplot2)
library(rCharts)
## ---- end

# Get Time Series Data
hviAllCity  = read.csv("./processedData/hviAllCity.csv", header = TRUE, stringsAsFactors = FALSE)
d <- subset(hviAllCity, StateName == "California" & City == "San Francisco", select = X2000.01:X2015.12)
d <- d[,]/1000
v  <- as.numeric(as.vector(d))
d  <- ts(v, frequency = 12, start = c(2000,1))

# Train Models
# ARIMA = auto.arima(d, ic='aicc', stepwise=FALSE)
# ETS = ets(d, ic='aicc', restrict=FALSE)
# NEURAL = nnetar(d, p=12, size=25)
# TBATS = tbats(d, ic='aicc', seasonal.periods=12)
# BATS = bats(d, ic='aicc', seasonal.periods=12)
# STLM = stlm(d, s.window=12, ic='aicc', robust=TRUE, method='ets')
# STS = StructTS(d, type = "level")
# NAIVE = naive(d, 12)

# Forecast 
fcastARIMA   <-   forecast(ARIMA, 120)
fcastETS   <-   forecast(ETS, 120)
fcastNEURAL   <-   forecast(NEURAL, 120)
fcastTBATS   <-   forecast(TBATS, 120)
fcastBATS   <-   forecast(BATS, 120)
fcastSTLM   <-   forecast(STLM, 120)
fcastSTS   <-   forecast(STS, 120)
fcastNAIVE   <-   forecast(NAIVE, 120)

#Plot Forecast
lgnd <- c("ARIMA", "ETS", "NAIVE", "NEURAL", "BATS", "TBATS", "STLM", "STS")
forecasts <- ts.union(fcastARIMA$mean,	fcastETS$mean,fcastNAIVE$mean, fcastNEURAL$mean, fcastBATS$mean, fcastTBATS$mean, fcastSTLM$mean,	fcastSTS$mean)
plot(forecasts, plot.type = "single", col = 1:ncol(forecasts), ylab = "($000)")
par(mar = c(5,4,1,2) + 0.1)
legend("topleft", lgnd, col = 1:ncol(forecasts), lty = 1)

#Get end of period prediction
fcastARIMA   <-   as.vector(as.numeric(fcastARIMA$mean[length(fcastARIMA$mean)]))
fcastETS   <-   as.vector(as.numeric(fcastETS$mean[length(fcastETS$mean)]))
fcastNEURAL   <-   as.vector(as.numeric(fcastNEURAL$mean[length(fcastNEURAL$mean)]))
fcastTBATS   <-   as.vector(as.numeric(fcastTBATS$mean[length(fcastTBATS$mean)]))
fcastBATS   <-   as.vector(as.numeric(fcastBATS$mean[length(fcastBATS$mean)]))
fcastSTLM   <-   as.vector(as.numeric(fcastSTLM$mean[length(fcastSTLM$mean)]))
fcastSTS   <-   as.vector(as.numeric(fcastSTS$mean[length(fcastSTS$mean)]))
fcastNAIVE   <-   as.vector(as.numeric(fcastNAIVE$mean[length(fcastNAIVE$mean)]))

#Plot end of period.
prediction <- as.vector(c(fcastARIMA,	fcastETS,	fcastNAIVE, fcastNEURAL,	fcastBATS, fcastTBATS,	fcastSTLM,	fcastSTS))
models <- c("Arima", "ETS", "Naive", "Neural", "BATS", "TBATS", "STLM", "STS")
d <- data.frame(models, prediction)
colnames(d) <- c("Model","Prediction")
p <- nPlot(Prediction~Model, data = d, type = "discreteBarChart", dom = "predictionPlot", height = 400, width = 600)
p$set(title = "Predicted Median Home Values at End of Forecast Period")
p$xAxis(staggerLabels = TRUE)
p$yAxis(axisLabel = "($000)", width = 60)
print(p)
