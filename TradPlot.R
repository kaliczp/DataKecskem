png(width=960)

pdf(width=14)

orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
par(mar=c(3.1,4.1,2.1,0), las = 2, fig = c(0, 0.87, 0, 1))
plot.zoo(Thetasum[,"K7ÉPth"], lwd=2, xaxs = "i", ylab = "", yaxt = "n",
         ylim = c(0,20), yaxs ="i", type="n", xaxt = "n", xlab = "")
grid(nx = NA, ny = NULL)
tick.month <- seq.Date(as.Date("2018-07-01"), as.Date("2021-04-01"), by = "1 month")
tick.year <- seq.Date(as.Date("2019-01-01"), as.Date("2021-01-01"), by = "1 year")
axis(1, at = tick.month, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = tick.year, tck = 1,
     col = "lightgray", lab = F, lwd = 2)
axis(1, at = tick.month[-1], lab=F)
par(mgp = c(3, 0.7, 0))
axis.Date(1, at = tick.month + 15, tcl = 0, format = "%b", cex.axis = 0.8 )
par(mgp = c(3, 1, 0))
yeartext <- c(tick.year - c(91,183,183), tick.year[length(tick.year)] + 50)
text(x = yeartext, y = rep(0.8, length(tick.year)), labels = format(yeartext, format = "%Y"), cex = 2, col = "lightgray")
lines(as.zoo(Thetasum[,"K7ÉPth"]), lwd = 2)
lines(as.zoo(Thetasum[,"K7ÉPth"] - 2 * Thetasum[,"K7ÉPsd"]), lty="dotted")
lines(as.zoo(Thetasum[,"K7ÉPth"] + 2 * Thetasum[,"K7ÉPsd"]), lty="dotted")
lines(as.zoo(Thetasum[,"K35Fth"]), lwd = 2, col = 2)
lines(as.zoo(Thetasum[,"K35Fth"] - 2 * Thetasum[,"K35Fsd"]), lty="dotted", col = 2)
lines(as.zoo(Thetasum[,"K35Fth"] + 2 * Thetasum[,"K35Fsd"]), lty="dotted", col = 2)
lines(as.zoo(Thetasum[,"K12Eth"]), lwd = 2, col = 3)
lines(as.zoo(Thetasum[,"K12Eth"] - 2 * Thetasum[,"K12Esd"]), lty="dotted", col = 3)
lines(as.zoo(Thetasum[,"K12Eth"] + 2 * Thetasum[,"K12Esd"]), lty="dotted", col = 3)
par(new = TRUE)
plot.zoo(Thetasum[,"K7ÉPth"], lwd=2, xaxs = "i",
         ylim = c(-200,0), yaxs ="i", type="n", axes = FALSE, xlab = "",
         ylab = "")
lines(as.zoo(csap.xts * -1), type = "h", col = "blue", lend = 1, lwd = 4)
axis(2, at=c(0,-50,-100), lab = c(0,50,100))
mtext("Precipitation [mm/day]", side = 2, line = 3, at = -25, las = 0)
Sys.setlocale("LC_TIME", orilocale)
legend(as.Date("2018-07-28"), -65, legend = c("Grassland", "Black locust", "Black pine", "Precipitation"), col = c(1:3, "blue"), lty=1, lwd = c(2, 2, 2, 3) , bg = "white")
par(mar=c(3.1,0,2.1,4.1), fig = c(0.87, 1, 0, 1), new = TRUE)
boxplot(Data ~ Place, data = talnedv.fac, ylim = c(0, 20), yaxs = "i", xaxt = "n", yaxt = "n", border = NA, frame = FALSE, col="white")
grid(nx = NA, ny = NULL)
axis(1, at = c(1,3,5), lab = c("BL", "GL", "BP"), cex.axis = 0.8)
axis(1, at = c(1,3,5), lab = FALSE, tck = 1, col = "lightgray", lty = "dotted")
boxplot(Data ~ Place, data = talnedv.fac, ylim = c(0, 20), yaxs = "i", xaxt = "n",
        yaxt = "n", col= c(2, "white", "gray", "white" ,3), add = TRUE)
means <- aggregate(Data ~ Place, talnedv.fac, mean)
points(c(1, 3, 5), means$Data, pch = 18)
lines(c(2,2), means[1:2, "Data"], lwd = 2)
lines(c(4,4), means[2:3, "Data"], lwd = 2)
text(2, means[2,2] + 0.5, paste(round(means[2,2] - means[1,2], 2),
                          "%, C. int. 95%  0.62-1.07, p-val.: 1.39e-11"),
                          srt = 90, adj = c(0,0.5))
text(4, means[2,2] + 0.5 , paste(round(means[2,2] - means[3,2], 2),
                          "%, C. int. 95% 1.48-1.95, p-val.: < 2.2e-16"),
     srt = 90, adj = c(0,0.5))
axis(4)
mtext("Soil moisture [%]", side = 4, line = 3, at = 10, las = 0)
