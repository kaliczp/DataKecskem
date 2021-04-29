## Excel
library(readxl)

nyers <- read_xlsx("Mérések_Kecskemét.xlsx","Munka2")

## Munka2
Thetamean <- as.data.frame(nyers)[-c(1:2),c(1:2,8,14)]
names(Thetamean) <- c("Date", "K7ÉP", "K35F", "K12E")
