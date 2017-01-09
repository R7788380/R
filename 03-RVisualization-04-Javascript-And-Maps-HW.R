# 請先用RDataMining-01所教，從pirate_path中抽取經緯度
# ps. 1分 = 1/60度
# 在利用這門課程所學會的知識，將事件繪製於地圖上
# 你可以輸入 hw() 來觀看參考答案
pirate <- read.table(pirate_path, fileEncoding = "BIG5", sep = ",") %>%
    filter(grepl("經緯度", V1, fixed = TRUE)) %>%
    mutate(latitude = substring(V1,7,11), longitude = substring(V1,16,21))
latitude <- as.numeric(substring(pirate$latitude,1,2)) + 
    as.numeric(substring(pirate$latitude,4,5))/60
longitude <- as.numeric(substring(pirate$longitude,1,3)) + 
    as.numeric(substring(pirate$longitude,5,6))/60
location <- data.frame(longitude = longitude,
                       latitude = latitude)
gg <- get_map(location = "Spratly Islands", zoom = 5) %>%
    ggmap(extent = "panel")
gg + geom_point(data = location, aes(x = longitude, y = latitude),
                alpha = 0.5, size = 5)