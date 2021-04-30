## Excel
library(readxl)

## Munka 2
nyers <- read_xlsx("Mérések_Kecskemét.xlsx","Munka2")

Thetaall <- as.data.frame(nyers)[-c(1:2),-c(2,7:8,13:14,19)]
names(Thetaall) <- c("Date", paste0("K7ÉP",1:4), paste0("K35F",1:4), paste0("K12E",1:4))

for(tti in 2:ncol(Thetaall)) {
Thetaall[,tti] <- as.numeric(Thetaall[,tti])
}
