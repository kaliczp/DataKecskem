## Excel
library(readxl)

## Munka 2
nyers <- read_xlsx("Mérések_Kecskemét.xlsx","Munka2")

Thetaall <- as.data.frame(nyers)[-c(1:2),-c(2,7:8,13:14,19)]
names(Thetaall) <- c("Date", paste0("K7ÉP",1:4), paste0("K35F",1:4), paste0("K12E",1:4))

for(tti in 2:ncol(Thetaall)) {
Thetaall[,tti] <- as.numeric(Thetaall[,tti])
}

## Remove empty rows
Thetaall <- Thetaall[!is.na(Thetaall[,2]),]

## Remove 0 values
Thetaall[Thetaall == 0]  <- NA
Thetaall.xts <- xts(Thetaall[,-1], Thetaall[,1])

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
Alldatacsak <- Alldata[3:188,]

for(tti in 1:4)
    Alldatacsak[,tti] <- as.numeric(Alldatacsak[,tti])

Alldatacsak$Date  <- as.Date('1899-12-30') + as.numeric(Alldatacsak$Date)

All.xts <- xts(Alldatacsak[,-1], Alldatacsak$Date)

## Három talajnedvesség átlag
talnedv <- as.data.frame(nyers[4:191,c(3,5,7)])
talnedv[,1] <- as.numeric(talnedv[,1])
talnedv[,2] <- as.numeric(talnedv[,2])
talnedv[,3] <- as.numeric(talnedv[,3])
names(talnedv) <- c("K7ÉP","K35F","K12E")

## Soilmoisture with factor place holders for plot
talnedv.mean <- coredata(Thetasum[,c(1,3,5)])
talnedv.fac <- data.frame(Data = as.vector(talnedv.mean),
                          Place = factor(rep(c("GL","BL","BP"), each = nrow(talnedv.mean)),
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

## talaj1.xts az új adatok alapján
talaj1.raw <- data.frame(read_excel("Abrajav/Fig4 GW - kiegészített.xlsx", col_names = FALSE))
colnames(talaj1.raw) <- c("Date", "GW")
talaj1.ok <- talaj1.raw[!is.na(talaj1.raw$GW),]
talaj1.xts <- xts(talaj1.ok$GW, as.Date(talaj1.ok$Date))

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
library(readxl)
nyers <- read_xlsx("Ábrák_talajnedv_10_90_200_angol.xlsx","10 cm")
Abr10cm.df <- as.data.frame(nyers)
PrecAbr10cm <- Abr10cm.df[, c(1,5)]
PrecAbr10cm <- PrecAbr10cm[!is.na(PrecAbr10cm[,2]), ]
Abr10cm.df <- Abr10cm.df[, -5]

PrecTime <- c(PrecAbr10cm[,1], PrecAbr10cm[nrow(PrecAbr10cm),1] + (1:2) * 24 * 60 * 60)
PrecAbr10cm.xts <- xts(c(PrecAbr10cm[,2],0,0), PrecTime)

Abr10cm.xts  <- xts(Abr10cm.df[,-1], Abr10cm.df[,1])
cm10.ep <- endpoints(Abr10cm.df[,1], on = "hours")
Abr10cmh.xts  <- period.apply(Abr10cm.xts, cm10.ep, mean)
oriAbr10cmh.xts <- Abr10cmh.xts
Abr10cmh.xts['2021-12-22 00:50/2021-12-25 22:50',1] <- NA
Abr10cmh.xts['2022-01-10 00:50/2022-02-16 22:50',1] <- NA

nyers <- read_xlsx("Ábrák_talajnedv_10_90_200_angol.xlsx","90 cm")
Abr90cm.df <- as.data.frame(nyers)
PrecAbr90cm <- Abr90cm.df[, c(1,5)]
PrecAbr90cm <- PrecAbr90cm[!is.na(PrecAbr90cm[,2]), ]
Abr90cm.df <- Abr90cm.df[, -5]

Abr90cm.xts  <- xts(Abr90cm.df[,-1], Abr90cm.df[,1])
cm90.ep <- endpoints(index(Abr90cm.xts), on = "hours")
Abr90cmh.xts  <- period.apply(Abr90cm.xts, cm90.ep, mean)


nyers <- read_xlsx("Ábrák_talajnedv_10_90_200_angol.xlsx","200 cm")
Abr200cm.df <- as.data.frame(nyers)
Abr200cm <- Abr200cm.df[, 1:4]
Abr200cm <- Abr200cm[!is.na(Abr200cm[,2]), ]

Abr200cm.xts  <- xts(Abr200cm[,-1], Abr200cm[,1])
cm200.ep <- endpoints(index(Abr200cm.xts), on = "hours")
Abr200cmh.xts  <- period.apply(Abr200cm.xts, cm200.ep, mean)
OriAbr200cmh.xts <- Abr200cmh.xts
plot(Abr200cmh.xts['2021-12-20 20:50/2021-12-22 08:50',2])
Abr200cmh.xts['2021-12-20 20:50/2021-12-22 08:50',2] <- 13.2
plot(Abr200cmh.xts['2021-12-28/2021-12-29',2])
14.98333 - 13.16667 # 1.8
Abr200cmh.xts['2021-12-28 23:50/',2] <- Abr200cmh.xts['2021-12-28 23:50/',2] - 1.8


## Napi adatok Bencétől
library(readxl)

Abr10cmd.df <- as.data.frame(read_xlsx("Napi_talajnedvesség_csapadék.xlsx", range = "A2:E236"))
AbrIdod.vec <- as.POSIXct(Abr10cmd.df[,1]) + 12 * 60 * 60
Abr10cmd.xts  <- xts(Abr10cmd.df[,-c(1,5)], AbrIdod.vec)

AbrCsapd.xts  <- xts(Abr10cmd.df[,5], AbrIdod.vec)
AbrCsapd.xts  <- c(AbrCsapd.xts, PrecAbr10cm.xts['2022'])

Csap202204.df <- as.data.frame(read_xlsx("2022évescsap.xlsx", 2))
AbrCsapd.xts <- c(AbrCsapd.xts['/2022-04-24'], xts(Csap202204.df[,2], Csap202204.df[,1] + 12 * 60 * 60))

Abr90cmd.df <- as.data.frame(read_xlsx("Napi_talajnedvesség_csapadék.xlsx", range = "J2:L236"))
Abr90cmd.xts  <- xts(Abr90cmd.df, AbrIdod.vec)

Abr200cmd.df <- as.data.frame(read_xlsx("Napi_talajnedvesség_csapadék.xlsx", range = "R2:T236"))
Abr200cmd.xts  <- xts(Abr200cmd.df, AbrIdod.vec)

## Méntelek újra
oricsap.xts <- csap.xts
Meentelek220510 <- as.data.frame(read_excel("Ábrák_talajnedv_10_90_200_angol.xlsx","Manual", "A3:E190"))

(Thetasum[-nrow(Thetasum),3] - Meentelek220510[,3]) > 0.1

Meentelek220510[,c(1,5)]
Meentelek220510Date <- as.Date(Meentelek220510[,1])

Meentelek.idx <- numeric()
for(tti in 1:length(Meentelek220510Date))
    Meentelek.idx[tti] <- which(index(csap.xts) == Meentelek220510Date[tti])

Meentelek.idx <- c(0,Meentelek.idx)
Meentelek.compare <- period.apply(csap.xts, Meentelek.idx, sum)
Meentelekcsap.xts <- xts(Meentelek220510[,5], Meentelek220510Date)
Meentelekcsap.xts['/2021-05-03']-Meentelek.compare
