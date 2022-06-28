Sys.setenv(TZ="UTC")
library(readxl)

raw <- as.data.frame(read_excel("HosszútávúTalajvízIdősorok8h.xlsx",2))
library(xts)
kut.xts <- xts(0 - raw[,-1], as.Date(paste0(raw[,1],"-07-01")))
plot(kut.xts)


csraw <- as.data.frame(read_excel("OMSZ_csapi_1940_8állomás_homok.xlsx",1, "A1:B81"))
cs.xts <- xts(csraw[,2], as.Date(paste(csraw[,1], 7, 1, sep="-")))

library(RColorBrewer)
Well.palette <- brewer.pal(8, "Dark2")

jpeg("GWWells.jpg", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)
jpeg("GWWells.jpg", width=17.8, height=11, units ="cm", res = 1000, pointsize = 11)
png("GWWells.png", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)

par(mar = c(2.3, 3.5, 0.5, 0.2), las = 1, mgp = c(2.5,0.6,0))
FigLim <- c(as.Date("1962-01-01"), as.Date("2014-01-01"))
plot.zoo(kut.xts[,1], ylim = c(-6,0), xlim = FigLim, lwd = 2,
         xaxs = "i", yaxs = "i", col = Well.palette[1], ylab = "GW [m below surface]")
for(tti in 2:ncol(kut.xts))
    lines(as.zoo(kut.xts[,tti]), col = Well.palette[tti], lwd = 2)
lines(zoo(rowMeans(kut.xts, na.rm = TRUE), index(kut.xts)), lwd = 3)
legend(as.Date("1965-01-01"), -4.3, legend = c("Average",names(kut.xts)), col = c("#000000", Well.palette), lwd = c(3, rep(2, length(Well.palette))), ncol = 3)
