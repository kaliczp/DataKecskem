jpeg("Fig8Moist200cm.jpg", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)
jpeg("Fig8Moist200cm1000.jpg", width=17.8, height=11, units ="cm", res = 1000, pointsize = 11)
png("Fig8Moist200cm.png", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)

Sys.setenv(TZ='UTC')
orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
tick.day <- seq.POSIXt(as.POSIXct("2021-05-12 00:00"), as.POSIXct("2022-05-14 00:00"), by = "1 day")
tick.month <- seq.POSIXt(as.POSIXct("2021-05-01 00:00"), as.POSIXct("2022-05-01 00:00"), by = "1 month")
par(mar=c(3.1,3.1,1.1,3.2), las = 1, mgp=c(2.2,1,0))
plot.zoo(Abr200cmh.xts[,1], type = "n",
         xlim = tick.day[c(1, length(tick.day))], ylim = c(0,55), yaxs = "i", xaxs = "i", xaxt = "n",
         xlab = "", ylab = "Soil moisture [%]")
grid(nx = NA, ny = NULL)
axis(1, at = tick.month, tck = 1,
     col = "lightgray", lty = "dotted", lab = F)
axis(1, at = tick.month, lab=F)
par(mgp = c(3, 0.7, 0))
axis.POSIXct(1, at = tick.month + 15 * 24 * 60 * 60, tcl = 0, format = "%b", cex.axis = 0.8 )
par(mgp = c(3, 2, 0))
axis.POSIXct(1, at = as.POSIXct(c("2021-09-12 00:00", "2022-03-10 00:00")), tcl = 0, format = "%Y", cex.axis = 0.8)
par(mgp = c(3, 1, 0))
lines(as.zoo(Abr200cmh.xts[,1]), lwd =2, col = 3)
lines(as.zoo(Abr200cmh.xts[,2]), lwd =2, col = 1)
lines(as.zoo(Abr200cmh.xts[,3]), lwd =2, col = 2)
par(new = TRUE)
plot(as.zoo(AbrCsapd.xts), type = "h", col = "lightblue", ylim = c(150,0),
        yaxs = "i", xaxs = "i", xaxt = "n", yaxt = "n", lwd = 2, lend = 2,
        xlim = tick.day[c(1, length(tick.day))], xlab = "", ylab = "")
axis(4, at = c(0,25,50))
mtext("Precipitation [mm/day]", side = 4, line = 2.2, at = 25, las = 0)
box()
legend(as.POSIXct("2021-06-01 00:00"), 50, legend = c("Black Locust", "Black Pine", "Control"), col = c(1:3, "blue"), lty=1, lwd = c(2, 2, 2) , bg = "white")

# barplot(as.zoo(PrecAbr200cm.xts), col = "lightblue", ylim = c(200,0),
#        yaxs = "i", xaxs = "i", xaxt = "n")
#        xlim = tick.day[c(1, length(tick.day)-3)])

Sys.setlocale("LC_TIME", orilocale)
