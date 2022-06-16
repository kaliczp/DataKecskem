## Average theta boxplot
boxplot(talnedv, ylim=c(0,15))

### tests for theta mean

## Normality
plot(density(talnedv$K7ÉP))
plot(density(talnedv$K35F))
plot(density(talnedv$K12E))

qqnorm(talnedv$K7ÉP)
qqline(talnedv$K7ÉP)

ttnorm <- rnorm(nrow(talnedv), mean(talnedv$K7ÉP), sd(talnedv$K7ÉP))
qqnorm(ttnorm)
qqline(ttnorm)

qqnorm(talnedv$K35F)
qqline(talnedv$K35F)

qqnorm(talnedv$K12E)
qqline(talnedv$K12E)

### t-test
var.test(talnedv$K7ÉP, talnedv$K35F, paired = TRUE)
t.test(talnedv$K7ÉP, talnedv$K35F, paired = TRUE)

t.test(talnedv$K7ÉP, talnedv$K35F, paired = TRUE, var.eq=TRUE)

var.test(talnedv$K7ÉP, talnedv$K12E, paired = TRUE)
t.test(talnedv$K7ÉP, talnedv$K12E, paired = TRUE, var.eq=FALSE)

var.test(talnedv$K35F, talnedv$K12E, paired = TRUE)
t.test(talnedv$K35F, talnedv$K12E, paired = TRUE, var.eq=TRUE)

## Vegetációs időszak máj-okt

wilcox.test(coredata(c(talnedv.xts['/2018-10-31', "K7ÉP"],
                       talnedv.xts['2019-05-01/2019-10-31', "K7ÉP"],
                       talnedv.xts['2020-05-01/2020-10-31', "K7ÉP"])),
            coredata(c(talnedv.xts['/2018-10-31', "K12E"],
                       talnedv.xts['2019-05-01/2019-10-31', "K12E"],
                       talnedv.xts['2020-05-01/2020-10-31', "K12E"])), paired = TRUE)

wilcox.test(coredata(c(talnedv.xts['/2018-10-31', "K7ÉP"],
                       talnedv.xts['2019-05-01/2019-10-31', "K7ÉP"],
                       talnedv.xts['2020-05-01/2020-10-31', "K7ÉP"])),
            coredata(c(talnedv.xts['/2018-10-31', "K35F"],
                       talnedv.xts['2019-05-01/2019-10-31', "K35F"],
                       talnedv.xts['2020-05-01/2020-10-31', "K35F"])), paired = TRUE)

## Vegetáción kívül
wilcox.test(coredata(c(talnedv.xts['2018-10-31/2019-05-01', "K7ÉP"],
                       talnedv.xts['2019-10-31/2020-05-01', "K7ÉP"],
                       talnedv.xts['2020-10-31/', "K7ÉP"])),
            coredata(c(talnedv.xts['2018-10-31/2019-05-01', "K35F"],
                       talnedv.xts['2019-10-31/2020-05-01', "K35F"],
                       talnedv.xts['2020-10-31/', "K35F"])), paired = TRUE)
wilcox.test(coredata(c(talnedv.xts['2018-10-31/2019-05-01', "K7ÉP"],
                       talnedv.xts['2019-10-31/2020-05-01', "K7ÉP"],
                       talnedv.xts['2020-10-31/', "K7ÉP"])),
            coredata(c(talnedv.xts['2018-10-31/2019-05-01', "K12E"],
                       talnedv.xts['2019-10-31/2020-05-01', "K12E"],
                       talnedv.xts['2020-10-31/', "K12E"])), paired = TRUE)


## Final stat
boxplot(Data ~ Place, data = talnedv.fac, ylim = c(0, 20), yaxs = "i", xaxt = "n", yaxt = "n", border = NA, frame = FALSE, col="white")

boxplot(Data ~ Place, data = talnedv.fac, ylim = c(0, 20), yaxs = "i", xaxt = "n",
        yaxt = "n", col= c("gray", "white", 3 , "white" ,2), add = TRUE)

## BLvsGL <- talnedv.fac[talnedv.fac$Place == "BL" | talnedv.fac$Place == "GL", ]

## var.test(Data ~ Place, data = BLvsGL, paired = TRUE)
## t.test(Data ~ Place, data = BLvsGL, paired = TRUE)

## talnedv.mean <- coredata(Thetasum[,c(1,3,5)])
talnedv.mean.stat <- talnedv.mean[!is.na(talnedv.mean[, "K7ÉPth"]),]
colnames(talnedv.mean.stat)  <- c("GL","BL","BP")

var.test(talnedv$GL, talnedv$BL, paired = TRUE)
t.test(talnedv$GL, talnedv$BL, paired = TRUE, var.eq=FALSE)

## GL vs BL
var.test(talnedv$K7ÉP, talnedv$K35F, paired = TRUE)
t.test(talnedv$K7ÉP, talnedv$K35F, paired = TRUE, var.eq = FALSE)

## GL vs BP
var.test(talnedv$K7ÉP, talnedv$K12E, paired = TRUE)
t.test(talnedv$K7ÉP, talnedv$K12E, paired = TRUE, var.eq=FALSE)
