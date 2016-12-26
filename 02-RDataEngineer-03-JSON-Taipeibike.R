library(jsonlite)
Taipeibike <- jsonlite::fromJSON("http://data.taipei/youbike")
Ex <- as.data.frame(Taipeibike)

sna <- sapply(Taipeibike$retVal, "[[", "sna")
tot <- sapply(Taipeibike$retVal, "[[", "tot")
sbi <- sapply(Taipeibike$retVal, "[[", "sbi")
sarea <- sapply(Taipeibike$retVal, "[[", "sarea")
lat <- sapply(Taipeibike$retVal, "[[", "lat")
lng <- sapply(Taipeibike$retVal, "[[", "lng")

Taipeibike_data <- data.frame(stringsAsFactors = FALSE,
                              sna = sna,
                              tot = tot,
                              sbi = sbi,
                              sarea = sarea,
                              lat = lat,
                              lng = lng)