library(dygraphs)
library(xts)
col1 <- read.csv("Evap_tavg.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("Evap_tavg.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("Evap_tavg.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("Evap_tavg.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("Evap_tavg.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("Evap_tavg.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("Evap_tavg.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("Evap_tavg.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

Evap_tavg <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_Evap_tavg <-apply(Evap_tavg, 1, function(x) mean(na.omit(x)));
max_Evap_tavg <-apply(Evap_tavg, 1, FUN=max, na.rm = TRUE);
min_Evap_tavg <-apply(Evap_tavg, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_Evap_tavg, max=max_Evap_tavg, min=min_Evap_tavg)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "Evapotranspiration") %>%
  dyAxis("x", drawGrid = TRUE 
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
  ) %>%
  dyAxis("y", valueRange = c(-4,4.1)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = "#993300")
