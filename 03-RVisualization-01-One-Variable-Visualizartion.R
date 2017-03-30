#介紹R視覺化單變量圖，也就是一維數據可視化
#plot圖會根據x,y輸入的不同而有不同的顯示情況
spon <- infert$spontaneous; mode(spon)  #資料型態為數值向量
plot(spon)  #plot圖如果收到一個數值向量時，會呈現散佈圖，看不出什麼特徵
#分別把資料中的spon[1],spon[2]呈現在圖上，(1,spon[1])、(2,spon[2])等等
spon <- as.factor(spon)
plot(spon) #如果收到類別向量(levels)或字串向量，會呈現直方圖，計算每個類別數量
#第一張圖當然比第二張圖好理解許多，這是因為我們將spon進行類別分類了
table(spon)
#所以R才能理解要根據levels進行分類
#測量尺度分類為四種量尺
#名目尺度(nominal scale):主要進行區分類別，給予每個類別名稱以供辨識，屬於離散
#Ex:組別、性別、宗教、科系等等
#順序尺度(ordinal scale):依特徵或屬性大小排成高低，可以相互比較，屬於離散
#Ex:名次、年級等等
#區間尺度(interval scale):除了具備上述類別名稱以及排序外，距離必須相同，連續
#Ex:成績0~100分依照20分類都是等距的，所以可以計算mean、sd，另外還有溫度等等
#比例尺度(ratio scale):跟區間不同於沒有絕對零點的性質，也就是沒有負值可以從零計算起
#Ex:身高、體重、薪水、年齡等等，數值間具有絕對意義
#絕對零點：溫度如果是0度，我們無法解釋為毫無溫度，只能解釋為低溫
#薪水有基本薪資這種絕對零點
#所以第二張圖是屬於順序尺度
spons <- table(spon); percent <- spons / sum(spons) * 100 ;percent <- round(percent, digits = 2)
pp <- paste0(names(spons), "=", percent, sep = "%")
pie(spons, labels = pp) 
#pie圓餅圖需要名稱和個數比率，需要先用table計算類別數量
pie(spon) #無法直接輸入factor

install.packages("plotrix") 
library(plotrix) 
pie3D(spons, labels = pp) #3D圓餅圖

#介紹直方圖histograms，直方圖歸類於連續型，所以只能接受區間尺度與比例尺度
age <- infert$age
x <- hist(age)
hist(age, breaks = 5)#年齡屬於比例尺度，所以可以呈現出直方圖
x #輸入假設變數顯示組距、次數、個數比率、組中位數、等距 等等資訊
#當知道了組距就能透過cut函數中的breaks來分類
cut(age, breaks = x$breaks) %>% plot() #輸入plot就能了解組距情況
cut(age, breaks = quantile(age)) %>% plot() #也能用四分位距來分類

density(age) %>% plot() #也可以用密度來顯示
#可以看出波峰、波谷、偏態、峰度、離群值等等，上式有正偏態的情形
#如何看出正偏態？ 偏態係數'γ'>0為正偏,'γ'=0為不偏,'γ'<0為負偏
#由動差法得知偏態係數µ3/σ^3為0.2239，所以為正偏態，基本上≈0也可以看做不偏態
#如何看出峰態？ 峰態係數'κ'>3為高峽峰,'κ'=0為常態峰,'κ'<3為低闊峰
#由動差法得知峰態係數µ4/σ^4為2.3008，所以為低闊峰

#其實直接用density函數來畫圖是類似估計的方法，我們在density沒辦法做breaks動作
#當樣本要趨近母體時，假設我們關心的一個數在觀察中出現了
#我們認為他出現的概率很大，所以和這一數較近的數出現概率也會不小，較遠則較小
#我們會希望畫出來的密度圖接近每個年紀所佔的比率
x$density #直方圖的density就是我們希望趨近的比率
#基於這種想法，我們能畫出密度圖
par(mfrow = c(1,2))
    hist(age)+ plot(density(age))
#這種用density來模擬真實情形的方法就叫做'核密度估計'(Kernel Density Estimation)
hist(age)+ plot(density(age, bw = 0.5))
?density #透過bw來設定曲線平滑度，寬度愈小則出現的峰愈多
#那我們到底該怎麼設定bandwidth的值呢？
#help中默認bw參數使用"nrd0"方法，不過"SJ"顯示出來更為精確
hist(age)+ plot(density(age, bw = "SJ"))

class(sunspot.year) #型態為時間序列ts
plot(sunspot.year) #針對時間序列的plot，type為"l"
y <- tail(sunspot.year, 100) 
plot(y);lines(y) #lines功能就是在原本plot上畫上type = "l"的線
#plot,hist,ggplot這種稱為高階繪圖函數，另起新圖
#lines,points稱為低階繪圖函數，修飾原圖
axis(2, at = seq(10, 200, 10), labels = seq(10, 200, 10))
#添加y軸數值axis.y

paste("123", LETTERS[1:5]) #paste函數默認在每個x後面有空格
paste0("123", LETTERS[1:5]) #paste0函數默認在每個x後面為空
paste("123","456",sep = ",") #sep加在字符串中間
paste0("123","456",sep = ",") #sep加在每組字符串後面
paste0(c("123","456"),sep = ",")



