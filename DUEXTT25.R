library(dygraphs)
library(xts)
col1 <- read.csv("DUEXTT25.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("DUEXTT25.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("DUEXTT25.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("DUEXTT25.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("DUEXTT25.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("DUEXTT25.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("DUEXTT25.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("DUEXTT25.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

DUEXTT25 <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_DUEXTT25 <-apply(DUEXTT25, 1, function(x) mean(na.omit(x)));
max_DUEXTT25 <-apply(DUEXTT25, 1, FUN=max, na.rm = TRUE);
min_DUEXTT25 <-apply(DUEXTT25, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_DUEXTT25, max=max_DUEXTT25, min=min_DUEXTT25)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "Dust AOD") %>%
  dyAxis("x", drawGrid = TRUE
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
  ) %>%
  dyAxis("y", valueRange = c(-4,4.1)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = "red")
