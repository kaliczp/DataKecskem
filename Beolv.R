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

## Munka1
nyers <- read_xlsx("Mérések_Kecskemét.xlsx","Munka1")

Alldata <- as.data.frame(nyers)[,1:4]
names(Alldata) <- c("Date", "WaterLevel","ThetaK7ÉP", "Prec")
Alldatacsak <- Alldata[3:136,]

for(tti in 1:4)
    Alldatacsak[,tti] <- as.numeric(Alldatacsak[,tti])

Alldatacsak$Date  <- as.Date('1899-12-30') + as.numeric(Alldatacsak$Date)

All.xts <- xts(Alldatacsak[,-1], Alldatacsak$Date)

## Három talajnedvesség átlag
talnedv <- as.data.frame(nyers[16:136,c(3,5,7)])
talnedv[,1] <- as.numeric(talnedv[,1])
talnedv[,2] <- as.numeric(talnedv[,2])
talnedv[,3] <- as.numeric(talnedv[,3])
names(talnedv) <- c("K7ÉP","K35F","K12E")

## Soilmoisture with factor place holders for plot
talnedv.fac <- data.frame(Data = unlist(talnedv, use.names = FALSE),
                          Place = factor(rep(c("GL","BL","BP"), each = nrow(talnedv)),
                                         levels = c("BL","dummy1","GL","dummy2","BP"))
                          )


######################################################################
## 2. ábra
nyerstalaj1 <- read_xlsx("2. ábra adatok0325.xlsx", 1)
nyerstalaj2 <- read_xlsx("2. ábra adatok0325.xlsx", 2)

tal1.Date <- as.Date(as.data.frame(nyerstalaj1[,1])[,1])
talaj1 <- as.data.frame(nyerstalaj1[,2:3])
names(talaj1) <- c("Prec", "GW")
talaj1.xts <- xts(talaj1, tal1.Date)

tal2.Date <- as.Date(as.data.frame(nyerstalaj2[,1])[,1])
talaj2 <- as.data.frame(nyerstalaj2[,2:3])
names(talaj2) <- c("Prec", "GW")
talaj2.xts <- xts(talaj2, tal2.Date)

vizignyers <- read_xlsx("2352_kút.xlsx","2352 Kecskemét")
## Data reduced to one day frequency
vizigp.df <- as.data.frame(vizignyers[,1:2])[seq(1,856,2),]
vizigp.xts <- xts(vizigp.df$Adat/-100, as.Date(vizigp.df$Időpont))

## Korrekciók
vizigpcorr.xts <- vizigp.xts
vizigpcorr.xts[1:226] <- vizigpcorr.xts[1:226]+0.06
vizigpcorrdat.xts <- xts(coredata(vizigpcorr.xts[seq(1,856,2),]),
                         as.Date(index(vizigpcorr.xts[seq(1,856,2),])))

vizigorinyers <- read_xlsx("TalajkutEszlelt(3).xlsx","2352 Kecskemét")
vizigori.df <- as.data.frame(vizigorinyers[,1:2])
vizigori.xts <- xts(vizigori.df$Adat/-100, as.Date(vizigori.df$Időpont))

## Daily prec
nyers <- read_xlsx("GSM/GSM_KECSKEMET17napi_havi.xlsx","napi")
csap.df <- as.data.frame(nyers[-(1:3),c(1,12)])
names(csap.df) <- c("Date","Prec")

for(ttev in 18:20) {
    nyers <- read_xlsx(paste0("GSM/GSM_KECSKEMET", ttev, "napi_havi.xlsx"),"napi")
    nextcsap.df <- as.data.frame(nyers[-(1:3),c(1,12)])
    names(nextcsap.df) <- c("Date","Prec")
    csap.df <- rbind(csap.df, nextcsap.df)
}
## Some correction rows deleted
csap.df <- csap.df[1:1461,]

csap.df[, "Date"] <- as.Date('1899-12-30') + as.numeric(csap.df[, "Date"])

csap.xts <- xts(as.numeric(csap.df[, "Prec"]), csap.df[, "Date"])

## 2021 precipitation
nyers <- read_xlsx("csapadék Méntelek 2021.xlsx","Sheet1")
csap2021 <- as.data.frame(nyers[-1,1:2])
names(csap2021) <- c("Date","Prec")
csap2021.xts <- xts(as.numeric(csap2021[,2]), csap2021[,1])
csap2021napi.xts <- apply.daily(csap2021.xts, sum)
csap.xts <- c(csap.xts, xts(coredata(csap2021napi.xts), as.Date(index(csap2021napi.xts))))


#### Talajned-csap ábra
nyers <- read_xlsx("Ábra adatok0719.xlsx","1. ábra (10 cm)")
Abr10cm.df <- as.data.frame(nyers)
PrecAbr10cm <- Abr10cm.df[, c(1,5)]
PrecAbr10cm <- PrecAbr10cm[!is.na(PrecAbr10cm[,2]), ]
Abr10cm.df <- Abr10cm.df[, -5]

nyers <- read_xlsx("Ábra adatok0719.xlsx","2. ábra (90 cm)")

nyers <- read_xlsx("Ábra adatok0719.xlsx","3. ábra (200 cm)")
