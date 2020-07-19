aod1 <- read.csv("DUEXTT25.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",")
aod2 <- read.csv("DUEXTT25.Algiers_monthly_anomaly.csv", header=FALSE, sep=",")
aod3 <- read.csv("DUEXTT25.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",")
aod4 <- read.csv("DUEXTT25.Beirut_monthly_anomaly.csv", header=FALSE, sep=",")
aod5 <- read.csv("DUEXTT25.Cairo_monthly_anomaly.csv", header=FALSE, sep=",")
aod6 <- read.csv("DUEXTT25.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",")
aod7 <- read.csv("DUEXTT25.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",")
aod <- rbind(aod3, aod4, aod5, aod6, aod7);
dim(aod)

st1 <- read.csv("AvgSurfT_inst.AbuDhabi_monthly_anomaly.csv", header=FALSE, sep=",")
st2 <- read.csv("AvgSurfT_inst.Algiers_monthly_anomaly.csv", header=FALSE, sep=",")
st3 <- read.csv("AvgSurfT_inst.Baghdad_monthly_anomaly.csv", header=FALSE, sep=",")
st4 <- read.csv("AvgSurfT_inst.Beirut_monthly_anomaly.csv", header=FALSE, sep=",")
st5 <- read.csv("AvgSurfT_inst.Cairo_monthly_anomaly.csv", header=FALSE, sep=",")
st6 <- read.csv("AvgSurfT_inst.Jerusalem_monthly_anomaly.csv", header=FALSE, sep=",")
st7 <- read.csv("AvgSurfT_inst.Riyadh_monthly_anomaly.csv", header=FALSE, sep=",")
st <- rbind(st3, st4, st5, st6, st7);
dim(st)

stringBaghdad = replicate(228, "Baghdad");
stringBeirut = replicate(228, "Beirut");
stringCairo = replicate(228, "Cairo");
stringJerusalem = replicate(228, "Jerusalem");
stringRiyadh = replicate(228, "Riyadh");
City = c(stringBaghdad, stringBeirut, stringCairo,
            stringJerusalem, stringRiyadh)

dataset <-data.frame(st, aod, City);

mod <- lm(dataset$V1.1~dataset$V1)
summary(mod)

library(plyr)
#rename(dataset, c("V1"="Surface_Temperature", "V1.1"="AOD", "stringX" = "City"))

library(ggplot2)
library(ggExtra)


#png("Dust_AOD_LST.png", units="in", width=6, height=5, res=300)
tiff("Dust_AOD_LST.tiff", units="in", width=6, height=5, res=300)

p1=ggplot(dataset, aes(x=V1, 
                        y=V1.1,
                       color= City
)) +
  scale_y_continuous(name = "Dust AOD") +
  scale_x_continuous(name = "Land Surface Temperature"
                     #limits = c(-0.3, 1.6)
  )+
  #scale_color_gradientn(colours = rainbow(3), values = c(0, 0.5, 2))+
  #scale_color_gradient(low="blue", high="red") +
  # scale_color_gradient2(limits=c(0, 2), midpoint=1.0, low="blue", mid="green", high="red", space ="Lab" )+
  geom_point() +
  geom_smooth(aes(x=V1, y=V1.1, color = NULL), method=lm, 
              linetype="dashed",colour = "red")+
 # ggtitle("Test") +
  theme(
    legend.position = c(0.08, 0.77)
    #legend.position = "none"
  ) 
p1 = p1 + geom_text(x=2.5, y=0.2, label.size = 0.5, label="y = 0.31x", color = "black")
p1
#ggMarginal(p1, type="boxplot", fill = "grey", size= 15)

dev.off()







