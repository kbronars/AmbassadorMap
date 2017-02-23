library(zipcode)
library(dplyr)
library(plyr)
AmbassadorZipcodes$ZipCode <- clean.zipcodes(AmbassadorZipcodes$ZipCode)
names(zips)[names(zips)=="Zipcode"] <- "ZipCode"
zips$ZipCode <- clean.zipcodes(zips$ZipCode)
zips$ZipCodeType <- NULL
zips$City <- NULL
zips$LocationType <- NULL
zips$Location <- NULL
zips$Decommisioned <- NULL
zips$TaxReturnsFiled <- NULL
zips$EstimatedPopulation <- NULL
zips$TotalWages <- NULL
AmbassadorZipcodes <- merge(AmbassadorZipcodes, zips, by = "ZipCode")
install.packages('rjson')
library(rjson)
install.packages('jsonlite')
library(jsonlite)
AmbassadorZipcodes <- toJSON(res1)
cat(AmbassadorZipcodes)
write.csv(AmbassadorZipcodes, file = "AmbassadorMap.csv", append = FALSE)
install.packages('ggplot2')
install.packages('maptools')
install.packages('mapdata')
install.packages('ggthemes')
install.packages('tibble')
install.packages('viridis')
install.packages("lazyeval", lib = "~/R/R-3.2.2/library")
library(ggplot2)
library(maptools)
gpclibPermit()
library(mapdata)
library(ggthemes)
library(tibble)
library(viridis)
install.packages('mapproj')
library(mapproj)

names(AmbassadorZipcodes)[names(AmbassadorZipcodes)=="Lat"] <- "lat"
names(AmbassadorZipcodes)[names(AmbassadorZipcodes)=="Long"] <- "long"
names(AmbassadorZipcodes)[names(AmbassadorZipcodes)=="State"] <- "state"

library(zipcode)
AmbassadorMap$zipcode <- clean.zipcodes(AmbassadorMap$zipcode)

##remove rows
AmbassadorMap <- AmbassadorMap[-c(4714, 4715, 4716, 5156, 5157, 5758, 5759, 5760, 5761, 5762, 5763, 5764, 5765, 5766), ]
AmbassadorMap <- AmbassadorMap[-c(429, 439, 4713), ]

us <- map_data("state")

choro_dat <- data_frame(some_other_name=unique(us$region),
                        some_critical_value=sample(10000, length(some_other_name)))

gg <- ggplot()
gg <- gg + geom_map(data=us, map=us,
                    aes(x=long, y=lat, map_id=region),
                    color="#2b2b2b", fill="#79d889", size=0.15)
gg <- gg + geom_point(data=AmbassadorMap,
                  aes(x=long, y=lat, map_id=zipcode),
                  shape=21, color="#2b2b2b", fill="#74c2fd", size=2)
gg <- gg + coord_map("polyconic")
gg <- gg + theme_map()
gg <- gg + theme(plot.margin=margin(20,20,20,20))
gg <- gg + scale
gg
