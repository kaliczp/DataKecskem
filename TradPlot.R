pdf(width=14)
par(mar=c(5.1,4.1,2.1,4.1), las = 1)
plot.zoo(Thetasum[,"K7ÉPth"], lwd=2, xaxs = "i", ylab = "Theta [%]",
         ylim = c(0,20), yaxs ="i", type="n", xaxt = "n", xlab = "")
grid(nx = NA, ny = NULL)
tick.month <- seq.Date(as.Date("2018-08-01"), as.Date("2021-04-01"), by = "1 month")
axis(1, at = tick.month, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = tick.month, lab=F)
axis.Date(1, at = tick.month + 15, tcl = 0, format = "%m")
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
lines(as.zoo(All.xts$Prec * -1), type = "h", col = "blue", lend = 1, lwd = 2)
axis(4, at=c(0,-50,-100), lab = c(0,50,100))
mtext("Csapadék [mm]", side = 4, line = 3, at = -25, las = 0)

