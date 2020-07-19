library(dygraphs)
library(xts)
col1 <- read.csv("SoilMoi0_10cm_inst.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
col2 <- read.csv("SoilMoi0_10cm_inst.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("SoilMoi0_10cm_inst.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("SoilMoi0_10cm_inst.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("SoilMoi0_10cm_inst.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("SoilMoi0_10cm_inst.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("SoilMoi0_10cm_inst.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
col8 <- read.csv("SoilMoi0_10cm_inst.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

SoilMoi0_10cm_inst <-data.frame(col1, col2, col3, col4, col5, col6, col7, col8);
ave_SoilMoi0_10cm_inst <-apply(SoilMoi0_10cm_inst, 1, function(x) mean(na.omit(x)));
max_SoilMoi0_10cm_inst <-apply(SoilMoi0_10cm_inst, 1, FUN=max, na.rm = TRUE);
min_SoilMoi0_10cm_inst <-apply(SoilMoi0_10cm_inst, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_SoilMoi0_10cm_inst, max=max_SoilMoi0_10cm_inst, min=min_SoilMoi0_10cm_inst)
data=xts(x = data[,-1], order.by = data$time)
head(data)

dygraph(data, main = "Soil Moisture in 10cm") %>%
  dyAxis("x", drawGrid = TRUE 
         #valueFormatter = 'function(d){return d.format("YYYY")}',
         #axisLabelFormatter = 'function(d){return d.format("YYYY")}'
  ) %>%
  dyAxis("y", valueRange = c(-4,4.1)
  ) %>%
  dySeries(c("min", "trend", "max")) %>%
  dyOptions(colors = "purple")
