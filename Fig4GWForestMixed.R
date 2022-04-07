jpeg("Fig4GWForestMixed.jpg", width=17.8, height=11, units ="cm", res = 300)
jpeg("Fig4GWForestMixed1000.jpg", width=17.8, height=11, units ="cm", res = 1000)
png("Fig4GWForestMixed.png", width=17.8, height=11, units ="cm", res = 300)

orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
par(mar=c(3.1,4.0,2.1,3.7), las = 2)
Fig2limits <- c(as.Date("2017-01-01"), as.Date("2021-04-30"))
plot.zoo(talaj1.xts$GW, type = "n", xaxs = "i", yaxs = "i",
         xlim = Fig2limits, xaxt = "n",
         ylim = c(-9.4, -7.0), yaxt = "n", ylab = "")
tick.month <- seq.Date(Fig2limits[1] - 2, Fig2limits[2], by = "1 month")
tick.year <- seq.Date(as.Date("2017-01-01"), Fig2limits[2], by = "1 year")
axis(1, at = tick.month, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = tick.year, tck = 1,
     col = "lightgray", lab = F, lwd = 2)
axis(1, at = tick.month, lab=F)
axis.Date(1, at = tick.month + 15, tcl = 0, format = "%b", cex.axis = 0.75)
yeartext <- c(tick.year + c(183, 183, 183, 130, 70))
text(x = yeartext[-length(yeartext)], y = rep(-9.3, length(tick.year)-1), labels = format(yeartext[-length(yeartext)], format = "%Y"), cex = 1.5, col = "lightgray")
axis(2, at = c(-8, -8.5, -9))
mtext("GW forest [m below surface]", side = 2, line = 3, at = -8.6, las = 0)
grid(nx = NA, ny = NULL)
lines(as.zoo(talaj1.xts$GW), lwd = 2)
par(new = TRUE)
plot.zoo(vizigori.xts, lwd = 2, xaxs = "i", yaxs = "i",
         xlim = Fig2limits, xaxt = "n",
         ylim = c(-5.4, -3.0), yaxt = "n", ylab ="", col = 2)
mtext("GW grassland [m below surface]", side = 4, line = 2.7, at = -4, las = 0, col = 2)
axis(4, at = c(-3.5, -4, -4.5), col = 2, col.tick = 2)
lines(as.zoo(vizigp.xts), lwd = 2, col = 2)
par(new = TRUE)
plot.zoo(csap.xts, xaxs = "i", yaxs = "i", type = "n",
         xlim = Fig2limits, xaxt = "n",
         ylim = c(240, 0), yaxt = "n", ylab ="")
axis(2, at = 25, tck = 1, col = "lightgray", lty = "dotted", lab = F)
lines(as.zoo(csap.xts), type = "h", col = "blue", lend = 1, lwd = 3)
axis(2, at = c(0, 25, 50), col.tick = "blue")
mtext("Precipitation", side = 2, line = 3.2, at = 25, las = 0, col = "blue")
mtext("[mm/day]", side = 2, line = 2.2, at = 25, las = 0, col = "blue")
Sys.setlocale("LC_TIME", orilocale)
legend(as.Date("2017-03-25"), 150, legend = c("Forest", "Agricultural & residential", "Precipitation"), col = c(1:2, "blue"), lty=1, lwd = c(2, 2, 3) , bg = "white", cex = 0.8)