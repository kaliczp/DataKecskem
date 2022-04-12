jpeg("Fig6Moist10cm.jpg", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)
jpeg("Fig6Moist10cm1000.jpg", width=17.8, height=11, units ="cm", res = 1000, pointsize = 11)
png("Fig6Moist10cm.png", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)

Sys.setenv(TZ='UTC')
orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
tick.day <- seq.POSIXt(as.POSIXct("2021-05-12 00:00"), as.POSIXct("2021-06-17 00:00"), by = "1 day")
par(mar=c(3.1,4.1,2.1,4.1), las = 2)
plot.zoo(Abr10cm.xts[,1], type = "n",
         xlim = tick.day[c(1, length(tick.day))], ylim = c(0,55), yaxs = "i", xaxs = "i", xaxt = "n",
         xlab = "", ylab = "Soil moisture [%]")
grid(nx = NA, ny = NULL)
axis(1, at = tick.day, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = as.POSIXct("2021-06-01 00:00"), tck = 1,
     col = "lightgray", lab = F)
axis(1, at = tick.day, lab=F)
par(mgp = c(3, 0.7, 0))
axis.POSIXct(1, at = tick.day + 12 * 60 * 60, tcl = 0, format = "%d", cex.axis = 0.8 )
par(mgp = c(3, 2, 0))
axis.POSIXct(1, at = as.POSIXct(c("2021-05-21 00:00", "2021-06-10 00:00")), tcl = 0, format = "%b", cex.axis = 0.8, las = 1)
par(mgp = c(3, 1, 0))
lines(as.zoo(Abr10cm.xts[,1]), lwd =2, col = 3)
lines(as.zoo(Abr10cm.xts[,2]), lwd =2, col = 1)
lines(as.zoo(Abr10cm.xts[,3]), lwd =2, col = 2)
par(new = TRUE)
plot(as.zoo(AbrCsapd.xts), type = "h", col = "lightblue", ylim = c(200,0),
        yaxs = "i", xaxs = "i", xaxt = "n", yaxt = "n", lwd = 15, lend = 2,
        xlim = tick.day[c(1, length(tick.day))], xlab = "", ylab = "")
axis(4, at = c(0,25,50))
mtext("Precipitation [mm/day]", side = 4, line = 3, at = 25, las = 0)
box()
legend(as.POSIXct("2021-06-01 00:00"), 100, legend = c("Black Locust", "Black Pine", "Control"), col = c(1:3, "blue"), lty=1, lwd = c(2, 2, 2) , bg = "white")
