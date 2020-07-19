library(dygraphs)
library(xts)
col1 <- read.csv("EVI.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("EVI.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("EVI.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("EVI.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("EVI.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("EVI.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("EVI.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("EVI.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

EVI <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_EVI <-apply(EVI, 1, function(x) mean(na.omit(x)));
max_EVI <-apply(EVI, 1, FUN=max, na.rm = TRUE);
min_EVI <-apply(EVI, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_EVI, max=max_EVI, min=min_EVI)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "EVI") %>%
  dyAxis("x", drawGrid = TRUE
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
  ) %>%
  dyAxis("y", valueRange = c(-4,4.1)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = "green")
