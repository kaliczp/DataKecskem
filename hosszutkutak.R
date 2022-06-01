Sys.setenv(TZ="UTC")
library(readxl)

raw <- as.data.frame(read_excel("HosszútávúTalajvízIdősorok8h.xlsx",2))
library(xts)
kut.xts <- xts(0 - raw[,-1], as.Date(paste0(raw[,1],"-07-01")))
plot(kut.xts)


csraw <- as.data.frame(read_excel("OMSZ_csapi_1940_8állomás_homok.xlsx",1, "A1:B81"))
cs.xts <- xts(csraw[,2], as.Date(paste(csraw[,1], 7, 1, sep="-")))

FigLim <- c(as.Date("1962-01-01"), as.Date("2014-01-01"))
plot.zoo(kut.xts[,1], ylim = c(-5,0), xlim = FigLim, lwd = 2, xaxs = "i", col = "gray")
for(tti in 2:ncol(kut.xts))
    lines(as.zoo(kut.xts[,tti]), col = "gray")
lines(zoo(rowMeans(kut.xts, na.rm = TRUE), index(kut.xts)), lwd = 3)
par(new = TRUE)
plot.zoo(cs.xts, type ="h", ylim = c(1500,300), xlim = FigLim, lwd = 4, col = "blue", xaxs = "i")
axis(4)
axis(2, at = 600, tck = 1, lty="dotted")
