library(dygraphs)
library(xts)
col1 <- read.csv("PRECTOT.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("PRECTOT.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("PRECTOT.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("PRECTOT.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("PRECTOT.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("PRECTOT.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("PRECTOT.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("PRECTOT.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

PRECTOT <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_PRECTOT <-apply(PRECTOT, 1, function(x) mean(na.omit(x)));
max_PRECTOT <-apply(PRECTOT, 1, FUN=max, na.rm = TRUE);
min_PRECTOT <-apply(PRECTOT, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_PRECTOT, max=max_PRECTOT, min=min_PRECTOT)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "Total Surface Precipitation") %>%
  dyAxis("x", drawGrid = TRUE
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
  ) %>%
  dyAxis("y", valueRange = c(-4,4.1)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = "orange")
