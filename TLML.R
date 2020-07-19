library(dygraphs)
library(xts)
col1 <- read.csv("TLML.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("TLML.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("TLML.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("TLML.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("TLML.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("TLML.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("TLML.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("TLML.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

TLML <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_TLML <-apply(TLML, 1, function(x) mean(na.omit(x)));
max_TLML <-apply(TLML, 1, FUN=max, na.rm = TRUE);
min_TLML <-apply(TLML, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_TLML, max=max_TLML, min=min_TLML)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "Surface Air Temperature") %>%
  dyAxis("x", drawGrid = TRUE 
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
  ) %>%
  dyAxis("y", valueRange = c(-4,4.1)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = "mint")
