Sys.setenv(TZ="UTC")
raw <- read.table("2352.csv", sep = "\t", head = TRUE)
kut <- raw[,1:2]
library(xts)
kut.xts <- xts(0 - kut[,2], as.POSIXct((strptime(kut[,1], format = "%Y. %m. %d. %H:%M"))))
plot(kut.xts)
plot(kut.xts['1979'])
points(kut.xts['1979'])

plot(kut.xts['1989'])
points(kut.xts['1989'])

plot(kut.xts['2009/2011'])
points(kut.xts['2009/2011'])

csraw <- read.table("OMSZcsapi.csv", sep = "\t", head = TRUE)
cs.xts <- xts(csraw[,2], as.POSIXct(paste(csraw[,1], 7, 1, sep="-")))

FigLim <- c(as.POSIXct("1940-01-01"), as.POSIXct("2021-01-01"))
plot.zoo(kut.xts, ylim = c(-500,50), xlim = FigLim, lwd = 2, xaxs = "i")
par(new = TRUE)
plot.zoo(cs.xts, type ="h", ylim = c(1500,300), xlim = FigLim, lwd = 4, col = "blue", xaxs = "i")
axis(4)
axis(2, at = 600, tck = 1, lty="dotted")
