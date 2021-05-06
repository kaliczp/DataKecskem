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
