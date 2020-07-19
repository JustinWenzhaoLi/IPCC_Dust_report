library(dygraphs)
library(xts)
col1 <- read.csv("AvgSurfT_inst.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("AvgSurfT_inst.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("AvgSurfT_inst.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("AvgSurfT_inst.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("AvgSurfT_inst.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("AvgSurfT_inst.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("AvgSurfT_inst.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("AvgSurfT_inst.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

AvgSurfT_inst <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_AvgSurfT_inst <-apply(AvgSurfT_inst, 1, function(x) mean(na.omit(x)));
max_AvgSurfT_inst <-apply(AvgSurfT_inst, 1, FUN=max, na.rm = TRUE);
min_AvgSurfT_inst <-apply(AvgSurfT_inst, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_AvgSurfT_inst, max=max_AvgSurfT_inst, min=min_AvgSurfT_inst)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "AvgSurfT_inst") %>%
  dyAxis("x", drawGrid = FALSE 
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
         ) %>%
  dyAxis("y", valueRange = c(-4,4.5)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set1"))
