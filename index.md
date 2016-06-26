---
title       : Introduction to shinyHome
subtitle    : Product Pitch
author      : John James
job         : Coursera Building Data Products, Data Science Specialization
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
ext_widgets : {rCharts: [libraries/nvd3]}

--- 



## Explore Markets
Explore over 20,000 markets by geography, home value price ranges and growth rates, then examine the distribution of home values, and discover the top markets by home value growth and, for the top growth markets, a time series of price movements since 2000.  

<div style='text-align: center;'>
    <img height='400' src='http://www.daelmann.com/code/dataScience/shinyHome/images/explorer.png' />
</div>

--- 

## Analyze Markets
Analyze home value price trends for selected markets. Evaluate non-seasonal price trends and decompose seasonal movements into their trend, seasonal and random components.

<div style='text-align: center;'>
    <img height='400' src='http://www.daelmann.com/code/dataScience/shinyHome/images/analyzer.png' />
</div>

--- 

## Train Forecast Models
Select a market, create training and test sets, then train eight of the most acknowledged time series forecasting algorithms, including Arima, Basic Structural, Naive, Neural Networks, Automated forecasting with exponential smoothing and others. Inspect forecast error statistics to evaluate forecast accuracy of each model.

<div style='text-align: center;'>
    <img height='400' src='http://www.daelmann.com/code/dataScience/shinyHome/images/train.png' />
</div>

--- &twocol

## Forecast Home Value Prices
Execute forecasts and compare predictions among the algorithms.  This is the 10 year forecast of median home values for San Francisco, California for each of the predictional algorithms. On the right, we have the predicted prices on Jan 1, 2026 for each of the models.

*** {name: left}
<iframe src=' assets/fig/forecast-1.html ' scrolling='no' frameBorder='0' seamless class='rChart nvd3 ' id=iframe- chart243502f6d76f ></iframe> <style>iframe.rChart{ width: 100%; height: 400px;}</style>

*** {name: right}
<iframe src=' assets/fig/prediction-1.html ' scrolling='no' frameBorder='0' seamless class='rChart nvd3 ' id=iframe- predictionPlot ></iframe> <style>iframe.rChart{ width: 100%; height: 400px;}</style>
