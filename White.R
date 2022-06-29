jpeg("White.jpg", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)
jpeg("White1000.jpg", width=17.8, height=11, units ="cm", res = 1000, pointsize = 11)
png("White.png", width=17.8, height=11, units ="cm", res = 300, pointsize = 11)

orilocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
par(mar=c(2.6,3.5,0.8,3.1), las = 2, mgp = c(3, 0.6, 0))
plot.zoo(White.Méntelek.xts, type = "n",
         xaxt = "n", yaxt = "n",
         xaxs = "i", yaxs = "i",
         ylim = c(-8.86,-8.71))
lines(as.zoo(White.Méntelek.xts), lwd = 2)
axis(4, at = c(-8.82, -8.84, -8.86))
par(new = TRUE)
plot.zoo(White.JszBrny.xts[,2], type = "n",
         xaxt = "n", yaxt = "n",
         xaxs = "i", yaxs = "i",
         ylim = c(-6.34,-6.19))
lines(as.zoo(White.JszBrny.xts[,2]), lwd = 2)
axis(2, at = c(-6.28, -6.30, -6.32, -6.34))
par(new = TRUE)
plot.zoo(White.JszBrny.xts[,1], type = "n",
         xaxt = "n", yaxt = "n",
         xaxs = "i", yaxs = "i",
         ylim = c(-6.06,-5.91))
lines(as.zoo(White.JszBrny.xts[,1]), lwd = 2)
axis(2, at = c(-5.92, -5.94, -5.96, -5.98))
