install.packages("googleVis")  #介紹更多元的視覺化套件
library(googleVis)
vignette(package = "googleVis") #一樣使用vignette介紹
vignette("googleVis_examples", package = "googleVis")
#googleVis所有函數名稱都是gvis__Chart，中間是你需要的圖類型
#1.需要網路才能使用   2.所有圖形輸入資料皆為data.frame
library(dplyr) #googleVis的API是需要我們整理完資料再載入的
dat1 <- group_by(hsb, race, sex) %>% 
    summarise(math.avg = mean(math))
g <- gvisBarChart(dat1) %>% plot()
#以Bar長條圖作例，所有輸出一律使用plot
g #輸入g會發現它是一個html，輸出還是一個網頁
g1 <- gvisLineChart(dat1) %>% plot()  #折線圖，鼠標移到上面還有註解
#會發現不管是Bar還是line，男女都是同樣顏色
#這是因為gvis是以column作為顏色判斷的標準，因為col只有一個sex
#並沒有分男col,女col
df <- data.frame(race = c("African American","Asian","Hispanic","White"),
                 female = c(47,56,45,53),male = c(45,58,49,54))
d <- gvisBarChart(df) %>% plot()
#假設將col分成了男女，gvis就能自行判斷有兩個類別，即兩個顏色
ggplot(dat1, aes(x = race, y = math.avg)) +
    geom_bar(aes(fill = sex), stat = "identity", position = "dodge") +
    coord_flip(ylim = c(40,60))
#使用ggplot也能達到一樣的效果

#googleVis判定顏色的標準在處理資料方面會造成困擾，所以介紹另外一個套件
install.packages("reshape2")
library(reshape2)
dcast(dat1, race ~ sex) #對race作sex的分類
dcast(dat1, race ~ sex) %>% gvisBarChart() %>% plot() 
select(hsb, read, math) %>% gvisScatterChart() %>% plot() #散佈圖

#跟ggplot2相比，googleVis簡單易懂，降低了技術門檻
#googleVis也有傳統Rplot沒有的繪圖類型
#Ex:Sankey chart, Calendar chart, Timeline chart等等
#如何用繪圖表達資料的趨勢成為了一種哲學
dat_sk <- data.frame(From = c(rep("A",3),rep("B",3)),To = c(rep(c("X","Y","Z"),2)),
                     Weights = c(5,7,6,2,9,4))
gvisSankey(dat_sk) %>% plot() #桑基圖，看出A,B兩種品牌分別在產品X,Y,Z的佔有率
#比照以往的佔有率來決策
gvisCalendar(TWII) %>% plot() #Calendar日曆圖
str(TWII) #注意使用Calendar時，Date的型態必須是日期型Date，Wush大已經整理好了
#<https://goo.gl/SNuAX7>，從網路上載下來的'日期'資料型態通常是factor
TWII2 <- read.csv("~/Downloads/table.csv",header = TRUE)
str(TWII2)  #Date型態為factor
TWII2$Date <- as.Date(TWII2$Date)#需使用as.Date來轉換型態
gvisCalendar(TWII2) %>% plot() 

gvisOrgChart(Regions) %>% plot()  #Organization組織圖
#還有很多繪圖類型都在googleVis examples裡面

library(devtools)
devtools::install_github("dkahle/ggmap") #介紹繪製地圖套件
library(ggmap) 
map <- get_map(location = "Taiwan", zoom = 8, language = "zh-TW",maptype = "roadmap")
#location參數可直接輸入地名，也可輸入經緯度
#zoom則是控制地圖縮放大小，3(大陸等級)~21(建築等級)
#語言則使用地區碼<https://goo.gl/GRKq7F>，這裡以繁體做比喻
#maptype有許多種類可選，預設treeain(地形)，還有roadmap(道路)、
#satellite(衛星)、hybrid(雜交)、toner-lite(黑白線路)等等
ggmap(map, darken = c(0.5,"black"),extent = "panel") #讓地圖變暗
ggmap(map, darken = c(0.5,"white")) #讓地圖變亮，其他顏色也可以
#extent參數預設"panel"，有刻度，"device"則沒有刻度，"normal"背景則會出現ggplot那樣的刻度

#<http://earthquake.usgs.gov> 下載世界地震資料，如何把地震資料畫在googlemap上
earthquake <- read.csv("~/Downloads/2.5_day.csv", header = TRUE)
g <- get_map(location = "Taiwan", zoom = 3) %>%
    ggmap(extent = "device")
#利用ggplot的圖層觀念，基層為我們的google地圖，在使用geom疊上去
g + geom_point(data = earthquake, aes(x = longitude, y = latitude,
                                      size = mag, color = magType))

