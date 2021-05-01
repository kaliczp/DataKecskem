par(mar=c(3.1,4.1,2.1,4.1), las = 1)
plot.zoo(talaj1.xts$GW['/2020-02-12'], lwd = 2, xaxs = "i", yaxs = "i",
         xlim = c(as.Date("2018-07-03"), as.Date("2020-02-12")),
         ylim = c(-9.2, -7.0), yaxt = "n", ylab = "")
axis(2, at = c(-8, -8.5, -9))
mtext("GW [m below surface]", side = 2, line = 3, at = -8.5, las = 0)
grid(nx = NA, ny = NULL)
par(new = TRUE)
plot.zoo(talaj2.xts$GW, lwd = 2, xaxs = "i", yaxs = "i",
         xlim = c(as.Date("2018-07-03"), as.Date("2020-02-12")),
         ylim = c(-5.2, -3.0), yaxt = "n", ylab ="", col = 2)
mtext("GW VIZIG [m below surface]", side = 4, line = 3, at = -4, las = 0, col = 2)
axis(4, at = c(-3.5, -4, -4.5), col = 2, col.tick = 2)
