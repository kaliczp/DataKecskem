jpeg("LongTerm.jpg", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)
jpeg("LongTerm1000.jpg", width=17.8, height=11, units ="cm", res = 1000, pointsize = 11)
png("LongTerm.png", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)

FigLim <- c(as.Date("1962-01-01"), as.Date("2013-12-31"))
par(mar=c(2.6,3.5,0.8,3.1), las = 1, mgp = c(3, 0.6, 0))
## GW
plot.zoo(LongTerm.xts[, "GW"], type = "n", xaxs = "i", yaxs = "i", xlim = FigLim,
         ylim = c(-4,1), lwd = 2,
         xlab = "", ylab = "",
         yaxt = "n")
axis(2, at =  - seq(1, 4, 0.5), tck = 1, col = "lightgray", lty = "dotted", lab = F)
lines(as.zoo(LongTerm.xts[, "GW"]), lwd = 2)
axis(2, at = -(1:4))
mtext("GW [m below surface]", side = 2, line = 2, at = -2.5, las = 0)
## Precipitation
par(new = TRUE)
plot.zoo(LongTerm.xts[, "Prec"], type ="n", xaxs = "i", yaxs = "i", xlim = FigLim,
         ylim = c(1640,300),
         xaxt = "n", yaxt = "n", ylab = "")
lines(as.zoo(LongTerm.xts[, "Prec"]), type = "h", col = "lightblue", lend = 1, lwd = 10)
axis(2, at = c(300,500,700))
axis(2, at = c(500,700), tck = 1, col = "lightgray", lty = "dotted", lab = F)
mtext("Precipitation [mm]", side = 2, line = 2, at = 500, las = 0, col = "blue")
## Temperature
par(new = TRUE)
plot.zoo(avgtemp.xts, type ="n", xaxs = "i", yaxs = "i", xlim = FigLim,
         ylim = c(11.5,16.5),
         xaxt = "n", yaxt = "n", ylab = "")
lines(as.zoo(avgtemp.xts), col = "red", lwd = 2)
axis(4, at = c(11:15))
mtext("Temperature [deg. C]", side = 4, line = 2, at = 13.5, las = 0, col = "red")
box()