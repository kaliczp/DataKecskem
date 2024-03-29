jpeg("Fig5SoilMoist.jpg", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)
jpeg("Fig5SoilMoist1000.jpg", width=17.8, height=11, units ="cm", res = 1000, pointsize = 11)
png("Fig5SoilMoist.png", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)

orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
par(mar=c(2.8,3.1,0.6,0), las = 2, fig = c(0, 0.8, 0, 1), mgp = c(3, 0.3, 0))
plot.zoo(Thetasum[,"K7ÉPth"], lwd=2, xaxs = "i", ylab = "", yaxt = "n",
         ylim = c(0,20), yaxs ="i", type="n", xaxt = "n", xlab = "")
grid(nx = NA, ny = NULL)
tick.month <- seq.Date(as.Date("2018-07-01"), as.Date("2022-05-01"), by = "1 month")
tick.year <- seq.Date(as.Date("2019-01-01"), as.Date("2023-01-01"), by = "1 year")
axis(1, at = tick.month, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = tick.year, tck = 1,
     col = "lightgray", lab = F, lwd = 2)
axis(1, at = tick.month[-1], lab=F)
par(mgp = c(3, 0.7, 0))
axis.Date(1, at = tick.month[-length(tick.month)] + 15, tcl = 0, format = "%b", cex.axis = 0.8 )
par(mgp = c(3, 1, 0))
yeartext <- c(tick.year - c(91,183,183, 183, 302))
text(x = yeartext, y = rep(0.8, length(tick.year)), labels = format(yeartext, format = "%Y"), cex = 1.2, col = "lightgray")
## Control
lines(as.zoo(Thetasum[,"K7ÉPth"]), lwd = 2, col = 3)
lines(as.zoo(Thetasum[,"K7ÉPth"] - 2 * Thetasum[,"K7ÉPsd"]), lty="dotted", col = 3)
lines(as.zoo(Thetasum[,"K7ÉPth"] + 2 * Thetasum[,"K7ÉPsd"]), lty="dotted", col = 3)
## Black locust
lines(as.zoo(Thetasum[,"K35Fth"]), lwd = 2, col = 1)
lines(as.zoo(Thetasum[,"K35Fth"] - 2 * Thetasum[,"K35Fsd"]), lty="dotted", col = 1)
lines(as.zoo(Thetasum[,"K35Fth"] + 2 * Thetasum[,"K35Fsd"]), lty="dotted", col = 1)
## Black pine
lines(as.zoo(Thetasum[,"K12Eth"]), lwd = 2, col = 2)
lines(as.zoo(Thetasum[,"K12Eth"] - 2 * Thetasum[,"K12Esd"]), lty="dotted", col = 2)
lines(as.zoo(Thetasum[,"K12Eth"] + 2 * Thetasum[,"K12Esd"]), lty="dotted", col = 2)
par(new = TRUE)
plot.zoo(Thetasum[,"K7ÉPth"], lwd=2, xaxs = "i",
         ylim = c(-200,0), yaxs ="i", type="n", axes = FALSE, xlab = "",
         ylab = "")
lines(as.zoo(Meentelekcsap.xts * -1), type = "h", col = "lightblue", lend = 1, lwd = 3)
axis(2, at=c(0,-50,-100), lab = c(0,50,100))
mtext("Precipitation [mm/week]", side = 2, line = 2.1, at = -50, las = 0)
Sys.setlocale("LC_TIME", orilocale)
legend(as.Date("2019-07-05"), -60, legend = c("Black Locust", "Black Pine", "Control"), col = c(1:3), lty=1, lwd = c(2, 2, 2) , bg = "white", cex = 0.93)
box()
par(mar=c(2.8,0,0.6,2.8), fig = c(0.8, 1, 0, 1), new = TRUE)
boxplot(Data ~ Place, data = talnedv.fac, ylim = c(0, 20), yaxs = "i", xaxt = "n", yaxt = "n", border = NA, frame = FALSE, col="white")
grid(nx = NA, ny = NULL)
axis(1, at = c(1,3,5), lab = c("BL", "C", "BP"), cex.axis = 0.8)
axis(1, at = c(1,3,5), lab = FALSE, tck = 1, col = "lightgray", lty = "dotted")
boxplot(Data ~ Place, data = talnedv.fac, ylim = c(0, 20), yaxs = "i", xaxt = "n",
        yaxt = "n", col= c("gray", "white", 3 , "white" ,2), add = TRUE)
means <- aggregate(Data ~ Place, talnedv.fac, mean)
points(c(1, 3, 5), means$Data, pch = 18)
lines(c(2,2), means[1:2, "Data"], lwd = 2)
lines(c(4,4), means[2:3, "Data"], lwd = 2)
axis(4)
mtext("Soil moisture [%]", side = 4, line = 1.8, at = 10, las = 0)
