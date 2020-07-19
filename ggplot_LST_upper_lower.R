library(dygraphs)
library(xts)
#col1 <- read.csv("AvgSurfT_inst.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",");
#col2 <- read.csv("AvgSurfT_inst.Algiers_monthly_anomaly.csv", header=FALSE, sep=",");
col3 <- read.csv("AvgSurfT_inst.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",");
col4 <- read.csv("AvgSurfT_inst.Beirut_monthly_anomaly.csv", header=FALSE, sep=",");
col5 <- read.csv("AvgSurfT_inst.Cairo_monthly_anomaly.csv", header=FALSE, sep=",");
col6 <- read.csv("AvgSurfT_inst.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",");
col7 <- read.csv("AvgSurfT_inst.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",");
#col8 <- read.csv("AvgSurfT_inst.Tehran_monthly_anomaly.csv", header=FALSE, sep=",");

AvgSurfT_inst <-data.frame(col3, col4, col5, col6, col7);
ave_AvgSurfT_inst <-apply(AvgSurfT_inst, 1, function(x) mean(na.omit(x)));
max_AvgSurfT_inst <-apply(AvgSurfT_inst, 1, FUN=max, na.rm = TRUE);
min_AvgSurfT_inst <-apply(AvgSurfT_inst, 1, FUN=min, na.rm = TRUE);
#
data=data.frame(time=seq(as.Date("2000/1/1"), by = "month", length.out = 228), 
                trend=ave_AvgSurfT_inst, max=max_AvgSurfT_inst, min=min_AvgSurfT_inst)
#data=xts(x = data[,-1], order.by = data$time)

tiff("LST.tiff", units="in", width=6, height=2, res=300)

ggplot(data) +
  geom_line(aes(y=trend, x=time, colour = "Average"))+
  scale_y_continuous(name = "Land Surface Temperature") +
  scale_x_date(date_breaks = "2 years" , date_labels = "%Y")+
  #geom_ribbon(aes(ymin=min_AvgSurfT_inst, ymax=min_AvgSurfT_inst, fill=ave_AvgSurfT_inst), alpha=0.4) + 
  geom_ribbon(aes(ymin=min, ymax=max, x=time, fill = "Range"), alpha = 0.3)+
  scale_colour_manual("",values="blue")+
  scale_fill_manual("",values="blue")+
  theme(legend.position="none", axis.title.x=element_blank())+
  stat_smooth(aes(y=data$trend, x=data$time), 
              linetype="dashed",
              color = "red", 
              #fill = "#FC4E07", 
              se = FALSE,
              method = "lm")
dev.off()