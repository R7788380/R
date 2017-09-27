#上一課程是介紹單變數以及plot,pie,hist基本函數
#這章節介紹多變數以及其他繪圖函數
tab1 <- table(hsb$sex, hsb$schtyp) #table計算次數，建立交叉表 
#我們要比較性別和公私立學校之間數量的關係
barplot(tab1, col = c("lightblue1","steelblue1"), ylab = "數量",main = "公私立男女比", 
        family = "楷體-繁 黑體",cex.names = 1.5, cex.axis = 1.2, beside = TRUE,
        legend.text = TRUE, args.legend = list(x=2, y=90))
?barplot#barplot條形圖，會根據height判斷輸出，height必須是vector or matrix
#以tab1為例，分出col中公私立再分出row男女數量
colors() #R內建colors來選擇顏色，可以使用grep來選擇顏色
colors()[grep("blue",colors())]
#xlab, ylab為x,y軸的標題名稱，main為標題，cex.name設定xlab的大小倍率
#cex.axis設定座標軸數值的大小倍率，beside = TRUE會將row分開表示，FALSE則疊一起
#legend.text = TRUE會出現說明圖示，args.legend以list來設定圖示的位置
#在OS中，plot圖的座標名稱沒辦法用中文顯示，要使用family = ""來設定字體
#OS的字體簿可以找出自己想要字型，複製過來就行

#barplot不只用在次數，還有其他方式
dat2 <- hsb %>% group_by(sex, schtyp) %>% summarise(math.avg = mean(math))
#先根據sex,schtyp分組，計算數學平均，被分類之後字串就會轉成factor
#計算完平均之後要從df轉換成交叉表給barplot讀取
tab2 <- xtabs(math.avg ~ sex + schtyp, data = dat2)
?xtabs #formula格式為 x~A+B+C...,這裡只取到A+B，因為barplot只接受到二維
#A會被放在row，B會被放在col，左邊放數值型態欄位，右邊放類別型態欄位
xtabs(~sex + schtyp, data = hsb) #沒有特別設定的話就跟table一樣計算次數
barplot(tab2, beside = TRUE, ylim = c(50,58), xpd = FALSE)
#ylim為y軸的範圍，因為ylim不是從0開始，所以會超出邊界
#與xpd = FALSE一起使用，表示圖不超過邊界，TRUE則會
barplot(tab2, beside = TRUE, names.arg = dimnames(tab2)$schtyp,
        xlim = c(50,58), xpd = FALSE, horiz = TRUE, las = 1)
#試著把圖弄成橫的，names.arg沒特別設定就是xtabs中的B，也就是col
#horiz = TRUE會把圖放衡，因為放橫之後y軸的公私立會變成直的，要弄成橫的較順眼

dat3 <- hsb %>% group_by(race) %>% summarise(read.med = median(read))
dotchart(dat3$read.med, labels = dat3$race, main = "Read\nmean",
         color = c("Red","Pink","Blue","Green"))
#一維點圖使用點圖dotchart函數 (二維使用plot)
plot(math ~ race, data = hsb) #plot也支援盒鬚圖
boxplot(math ~ race, data = hsb) #兩者輸出只差在plot會出現xlab和ylab
#盒鬚圖包含quantile中五個指標以及outlier
#像上式就是根據race中四個類別分別挑出quantile和outlier
boxplot(math ~ schtyp, data = hsb, col = c("darkblue", "gold"), 
        horizontal = TRUE) #一樣可以放橫著
legend("right", legend = c("private","public"),
       fill = c("darkblue", "gold"),title = "schtyp",inset = 0.05)
#legend圖示函數，可以將說明圖示放在圖形特定位置
#有'bottomright','bottom','bottomleft','topright','top','topleft','right',
#'left','center'，insect表示跟圖示跟邊筐的距離
#因為這題是盒鬚圖，說明圖裡面的圖形是小方塊，所以需要用fill參數來設定顏色
legend("topleft", legend = c("private","public"),
       col = c("darkblue", "gold"), lwd = 2)
#如果今天是線圖而不是盒鬚圖，說明圖圖示就需要使用線來代替
#要使用col和lwd來配合，lwd代表線條的粗細
help("~")
plot(read ~ math, data = hsb)
#Y~X，Y為被解釋變數，X為解釋變數，代表Y依照X分組
#表示math中200個成績分別解釋read中200個成績
plot(~math + read, data = hsb)
#沒有了被解釋變數，剩下2個解釋變數，跟上式等價
plot(~read+math+science+socst,data = hsb)
#個別解釋4x3個回歸關係

col.sex <- ifelse(hsb$sex=="male", "Red", "yellow3")
#ifelse函數條件函數
pch.schtyp <- ifelse(hsb$schtyp=="public",2, 24)
cex.science <- (hsb$science-25)/50*5
plot(~read+math,data = hsb, col = col.sex, pch = pch.schtyp, cex = cex.science)
#<http://blog.qiubio.com:8080/archives/2395>
#顏色、圖形代碼等等
#pch控制點的符號，cex控制放大縮小倍率





