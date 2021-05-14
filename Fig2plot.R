pdf(width=14)
orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
par(mar=c(3.1,4.1,2.1,4.1), las = 1)
Fig2limits <- c(as.Date("2018-07-03"), as.Date("2021-02-16"))
plot.zoo(talaj1.xts$GW, type = "n", xaxs = "i", yaxs = "i",
         xlim = Fig2limits, xaxt = "n",
         ylim = c(-9.4, -7.0), yaxt = "n", ylab = "")
tick.month <- seq.Date(Fig2limits[1] - 2, Fig2limits[2], by = "1 month")
tick.year <- seq.Date(as.Date("2018-01-01"), Fig2limits[2], by = "1 year")
axis(1, at = tick.month, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = tick.year, tck = 1,
     col = "lightgray", lab = F, lwd = 2)
axis(1, at = tick.month, lab=F)
axis.Date(1, at = tick.month + 15, tcl = 0, format = "%b", cex.axis = 0.75)
yeartext <- c(tick.year + c(275, 183, 183))
text(x = yeartext, y = rep(-9.3, length(tick.year)), labels = format(yeartext, format = "%Y"), cex = 2, col = "lightgray")
axis(2, at = c(-8, -8.5, -9))
mtext("GW [m below surface]", side = 2, line = 3, at = -8.5, las = 0)
grid(nx = NA, ny = NULL)
lines(as.zoo(talaj1.xts$GW), lwd = 2)
par(new = TRUE)
plot.zoo(vizigori.xts, lwd = 2, xaxs = "i", yaxs = "i",
         xlim = Fig2limits, xaxt = "n",
         ylim = c(-5.4, -3.0), yaxt = "n", ylab ="", col = 2)
mtext("GW VIZIG [m below surface]", side = 4, line = 3, at = -4, las = 0, col = 2)
axis(4, at = c(-3.5, -4, -4.5), col = 2, col.tick = 2)
lines(as.zoo(vizigp.xts), lwd = 2, col = 2)
par(new = TRUE)
plot.zoo(csap.xts, xaxs = "i", yaxs = "i", type = "n",
         xlim = Fig2limits, xaxt = "n",
         ylim = c(240, 0), yaxt = "n", ylab ="")
axis(2, at = 25, tck = 1, col = "lightgray", lty = "dotted", lab = F)
lines(as.zoo(csap.xts), type = "h", col = "blue", lend = 1, lwd = 3)
axis(2, at = c(0, 25, 50), col.tick = "blue")
mtext("Precipitation [mm/day]", side = 2, line = 3, at = 25, las = 0, col = "blue")
Sys.setlocale("LC_TIME", orilocale)
legend(as.Date("2018-07-28"), 165, legend = c("Forest", "Open-field", "Precipitation"), col = c(1:2, "blue"), lty=1, lwd = c(2, 2, 3) , bg = "white")
