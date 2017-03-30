#介紹繪圖功能更加強大的套件ggplot2，網路上有許多人製作的樣本可以拿來使用
#只要修改變數就可以達到你想要的結果
#<http://docs.ggplot2.org/current/> ggplot2套件繪圖指令
#ggplot2作圖步驟：
#1.資料來源 2.設定Aesthetic attributes 3.指定Geometric objects
ggplot(infert, aes(x = education)) + 
    geom_bar(data = subset(infert,education == "0-5yrs"),fill = "blue", alpha = 0.5, col = "grey") +
    geom_bar(data = subset(infert,education == "6-11yrs"),fill = "red", alpha = 0.5, col = "grey") +
    geom_bar(data = subset(infert,education == "12+ yrs"),fill = "green",alpha = 0.5, col = "grey") + 
    ggtitle("Education")
#infert資料來源以及Aes拿出教育數據，接下來指定幾何geomtric
#ggplot是使用'+'來修飾圖形，就是圖層一層一層疊上去的意思
#上述的意思就是抽出infert的教育數據，再指定每個類別的幾何參數
#geom_bar跟barplot很像，都是使用fill來選顏色，alpha是透明度，col是圖形邊線的顏色
#在plot中的參數很多都跟ggplot很像，ggtitle就跟main很像
#ggplot2所產生的圖看起來更有層次感，網狀背景跟座標數值也配合

qplot(education, data = infert, geom = "bar") 
#qplot也是ggplot2套件裡面的畫圖參數，跟R原有的plot很像
#qplot只是把ggplot和加入圖層的動作包裝成一個函數而已
#而在ggplot則要使用aes函數來包裝

?geom_bar #使用geom_bar來說明
#第一個參數mapping是共通的函數，geom開頭的幾何圖都有這個參數
#指定時使用aes函數，沒有指定則使用ggplot的預設值
#data指定資料來源，通常省略，預設使用ggplot的預設值
ggplot(hsb) +
    geom_bar(aes(x = sex, fill = race),position = "dodge")
ggplot(hsb, aes(x = sex)) +
    geom_bar(aes(fill = race), position = "dodge")
ggplot(hsb, aes(x = sex, fill = race)) +
    geom_bar(position = "dodge") 
#這三式有一樣的結果
#第一式沒有任何限制，建立ggplot基本圖層之後，使用geom來修飾
#第二式則指定了之後的修飾都要依照'sex'資料來畫圖
class(hsb$race) #類別為factor，所以fill可以依照levels來分顏色
#position是位置參數，dodge表示圖形要錯開，跟plot的beside = TRUE很像
#position預設stack主要比較男女個數
#而設定dodge之後重點在於同一個race中，sex個數的差異
 
library(dplyr) #載入dplyr包
x <- hsb %>% group_by(sex) %>% summarise(counts = n())#計算sex的個數
#我們的目的是要顯示sex中男女個數
ggplot(x, aes(x = sex)) + geom_bar()
#上式R會理解成'x'df中female和male的個數各為1，而不是count
ggplot(x, aes(x = sex, y = counts)) + geom_bar(stat = "identity")
#stat參數表示統計的方法，identity為依照自己定義的counts去輸出
#不會使用預設的count，geom_bar的stat預設為count(數量)

ggplot(hsb, aes(x = math)) + geom_density()#密度圖
ggplot(hsb, aes(x = math, fill = sex)) + geom_density(alpha = 0.5)

dat2 <- hsb %>% group_by(sex, schtyp) %>% summarise(math.avg = round(mean(math),digits = 2))
#根據性別,公私立分別算出數學平均
ggplot(dat2, aes(x = sex, y = math.avg, fill = schtyp)) +
    geom_bar(stat = "identity", position = "dodge", alpha = 0.5) +
    coord_cartesian(ylim = c(40,60)) 
#x軸根據性別,y軸為分數高低,顏色則根據公私立填滿
#stat不是count而是自己定義，position不要疊在一起dodge，透明度0.5
#y軸刻度預設從0開始看起來不明顯，設定笛卡爾座標c(40,60)放大差異

ggplot(dat2, aes(x = sex, y = math.avg, color = schtyp)) +
    geom_point(size = 10, alpha = 0.5) +
    coord_flip() +
    theme(axis.title.y = element_text(size = 10,angle = 0)) +
    geom_text(aes(label = math.avg, vjust = -2,hjust = 1, angle = -45))
#geom_point點圖使用color而不是fill，與dotchart很像，size設定點大小，alpha=0.5
#透明度有什麼用呢？ 有時候一個點可能重複好幾次，設定透明度可以看出重複情形
#coord_filp表示放橫，跟plot的horiz = TRUE一樣
?theme#theme函數專門用來修改座標軸標籤，看裡面的elemet
#針對座標軸數值修改都在coord開頭函數
#geom_text函數是用來調整顯示在圖案旁邊的內容，label = math.avg照著平均
#vjust調整橫向，hjust調整縱向，angle = -45表示順時針45度

ggplot(hsb, aes(x = sex, y = math, fill = schtyp)) + 
    geom_boxplot(aes(linetype = race)) 
#也有盒鬚圖，線條類型根據race四種分出不同類型
#可以觀察出西班牙女性公私立數學程度落差很大

cb7 <- c("#000000","#E69F00", "#56B4E9", "#009E73","#F0E442","#0072B2", "#D55E00","#CC79A7")
#使用16進制顏色代碼 <https://www.toodoo.com/db/color.html>
ggplot(hsb, aes(x = sex, fill = race)) + 
    geom_bar() +
    scale_fill_manual(values = cb7)
#scale開頭是用於美術方面的函數，包含顏色符號size、連續不連續
#像scale_fill_manual是用於填充色直方圖盒鬚圖且手動設定顏色函數
#scale_color_manual是用於點、線的顏色

g <- ggplot(hsb, aes(x = read, y = math)) + 
        geom_point()
g + facet_grid(~race) #按照race進行分組
g + facet_wrap(~race, ncol = 2) #wrap可以自訂要分成幾個col

install.packages("GGally") #一次畫出多筆數據倆倆之間的散佈圖
library(GGally) #載入GGally套件
ggpairs(hsb, 7:10) #分別比較read,write,math,science之間的關係



