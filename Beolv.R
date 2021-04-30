## Excel
library(readxl)

## Munka 2
nyers <- read_xlsx("Mérések_Kecskemét.xlsx","Munka2")

Thetaall <- as.data.frame(nyers)[-c(1:2),-c(2,7:8,13:14,19)]
names(Thetaall) <- c("Date", paste0("K7ÉP",1:4), paste0("K35F",1:4), paste0("K12E",1:4))

for(tti in 2:ncol(Thetaall)) {
Thetaall[,tti] <- as.numeric(Thetaall[,tti])
}

library(xts)
Thetasum <- xts(data.frame(K7ÉPth = rowMeans(Thetaall[,2:5]),
                           K7ÉPsd = apply(Thetaall[,2:5], 1, sd),
                           K35Fth = rowMeans(Thetaall[,6:9]),
                           K35Fsd = apply(Thetaall[,6:9], 1, sd),
                           K12Eth = rowMeans(Thetaall[,10:13]),
                           K12Esd = apply(Thetaall[,10:13], 1, sd)),
                as.Date(Thetaall[,1])
                )
