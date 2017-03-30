library(tools)
tools::md5sum(files = ) #檢查檔案是否毀損??
readLines(file(power_path,encoding = "BIG-5"),n = 2)
#通常編碼不是UTF-8就是BIG-5，顯示成功就是對的編碼
power <- readLines(file(power_path,encoding = "BIG-5"))
head(power) #readLines輸出字串向量，看出分隔符號是';\t'
power[c(188:204,732:748)] #要注意的是，不是所有字串分隔符號都是';\t'，像188:204中間只有'\t'
#而732:748則是';    \t'

x <- read.csv(power_path,fileEncoding = "BIG-5",sep = ";",header = FALSE)
x[c(186:189),]
#如果我們不檢查而直接進行讀取，屆時188:204的資料會排列錯誤，很可能還要重新分析資料
#因為sep只能接受一個字元，視情況而另尋他法
#因為資料不大，所以可以直接針對188:204進行整理
#或者先以字串讀取切割，再弄成data.frame也可以


power.split <- strsplit(power,split = ";?\t")
#我們知道資料中有';\t'、'\t'以及';  \t'這三種分割符號
#使用';?\t'，'?'問號告訴R前面的';'可有可無，處理';\t'、'\t'兩種分割符號
power.split[[732]]
#strsplit輸出為list，不過732:748中間的';  '沒有被分割，需要注意
#接下來要對每個list以row合併成一個data.frame
power.mat <- do.call("rbind",power.split)
#do.call的作用就是呼叫函數來對list進行rows合併
class(power.mat) #注意合併後型態為矩陣，需要轉為data.frame
power.df <- data.frame(power.mat,stringsAsFactors = FALSE)
#strings設定FALSE以字串型態呈現
colnames(power.df) <- c("id","name","year","power")#設定colnames
power.df$name <- factor(power.df$name)
power.df$year <- as.integer(power.df$year)
power.df$power <- as.numeric(power.df$power)
head(power.df)
all(!is.na(power.df)) #檢查是否有遺失值，all函數檢查一個邏輯向量中是否都為TRUE
all(complete.cases(power.df)) #等價

power.target <- filter(power.df,grepl("^[A-Z]",id),year == 91)
#找出字首為英文字母A:Z的rows，且年份為91

g <- ggplot(power.target,aes(x = name,y = power))
g + geom_bar(stat = "identity") + 
    theme_set(theme_gray(base_family = "STKaiti")) +
    theme(axis.text.x = element_text(angle = 45,vjust = 0.5))
#畫出barchart，以及中文顯示問題，還有字串會重疊的問題，調整角度、高度
ggplot(power.target,aes(x = "",y = power, fill = name)) + 
    geom_bar(stat = "identity") + 
    coord_polar(theta = "y") #ggplot2的pie chart
#ggplot2對pie chart支援不是很好，請看下列網址
#<http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html>

#由圖得知製造業是在當年用電量佔了一半以上
#好奇GDP是否也佔了一半以上
readLines(file(gdp_path,encoding = "BIG-5"),n = 10)
#由於`"`在R中是代表字串的開始和結束，所以R 會在顯示字串時，
#在`"`之前加註`\`，所以一個`\"`實際上就是一個`"`
cat(readLines(file(gdp_path,encoding = "BIG-5"),n = 20),sep = "\n")
#使用cat函數將字串間插入斷行\n
#先使用file做出connection，給readLines讀取，在使用cat斷行
gdp <- file(gdp_path,encoding = "BIG-5") %>% readLines(n = 20) %>% cat(sep = "\n")
#等價

gdp.split <- strsplit(gdp,split = ",")
length(gdp.split[5]) #用長度來做篩選，年份長度為1
gdp.split[(sapply(gdp.split, length) == 1) %>% which()]
#前7筆為年份
year.index <- (sapply(gdp.split,length) == 1) %>% which() %>% head(7)
#當知道了年份，就能以年份做切割
#切割年份需要頭與尾，第一個年份的資料從開始到結束為2007～2008
#不可能一個年份慢慢抽出，太慢了，需要寫迴圈
year.start <- year.index #頭
year.end <- c(tail(year.index,-1),length(gdp.split)) #尾為資料的最後一筆
gdp.value <- list() #建立list，等等讓for迴圈讀入
for (i in 1:7) { #7個年份
    start <- year.start[i]
    end <- year.end[i]
    year <- gdp.split[start] %>% 
        gsub(pattern = '"',replacement = '',fixed = TRUE) #年份整理，'"'用空白替換
    value1 <- gdp.split[start:end]
    value2 <- do.call(rbind,value1[sapply(value1,length) == 3]) #挑出年份資料(長度為3)
    value2[,1] <- year #長度為3，第一個為空白，可以用來放年份
    value2[,2] <- gsub(pattern = '"',replacement = '',value2[,2])
    #第二個為產業類別，有'"'，需要用空白替換，第三個為gdp
    gdp.value[[i]] <- value2
    gdp.df <- do.call(rbind,gdp.value) %>% data.frame(stringsAsFactors = FALSE)
    colnames(gdp.df) <- c("year","category","gdp")
}
class(gdp.df$year);class(gdp.df$category);class(gdp.df$gdp)
gdp.df$year <- as.integer(gdp.df$year) #轉換型態
gdp.df$gdp <- as.numeric(gdp.df$gdp)  
#轉換過程中出現NA
gdp.df[!complete.cases(gdp.df$gdp),] #NA值在425row
gdp.df <- gdp.df[complete.cases(gdp.df$gdp),] #過濾有NA的row

#知道了GDP和power的數據之後，需要比對資料，找出一致性
unique(gdp.df$category)
unique(power.df$id) #拿gdp的名稱代號跟power的id做比較
#目的是切割出gdp的代號然後與power的id配對
library(magrittr) #%<>%函數
gdp.df %<>% mutate(id = strsplit(category, ".",fixed = TRUE) %>% 
                      sapply("[", 1)) 
#以'.'做切割，挑選第一個字串，排在gdp.df後面當作一個colnum
#'%<>%'這個函數表示%>%過去之後，會將結果回存到變數本身
unique(gdp.df$id) #夾雜了中英文
gdp.df2 <- filter(gdp.df,nchar(id) == 1) #只需要單一文字的代號
unique(gdp.df2$id) #只剩下單一英文代號
#接下來挑出power.df開頭是英文的id，年份轉為西元，並且整理
power.df2 <- filter(power.df,grepl(pattern = "^[A-Z]",id)) %>%
    mutate(year = year+1911, id = gsub(pattern = ".",replacement = "",id,fixed = TRUE))
#因為'.'是正規表示式，fixed = TRUE

distinct(power.df2,id,name) #檢查power.df2的id和gdp.df2的id是不是都配對到一樣的產業類別
distinct(gdp.df2,id,category)
#如果這裡要使用all.equal，兩筆資料的name字串格式要一樣，太麻煩了
#比對過後發現，power.df2裡面有些類別是gdp.df2裡面類別的組合
#像power.df2的D就是gdp.df2的D+E之類的，像這種就只能靠判斷慢慢去配對
translations <- data.frame(power = c("A","B","C","D","E","F","G","H","I+J","K"),
                           gdp = c("A","B","C","D+E","F","G+I","H+J","K+L","M+N+P+Q+R+S","O"))
#產業類別配對
translation.power <- local({
    x <- c(1,2,3,4,5,6,7,8,9,9,10)
    names(x) <- c("A","B","C","D","E","F","G","H","I","J","K")
    x
})#知道了怎麼配對就能進行歸類，I與J都被歸在9這類
#這裡要先假設變數x才能使用names去命名，不能先用names
translation.gdp <- local({
    y <- c(1,2,3,4,4,5,6,7,6,7,8,8,9,9,10,9,9,9,9)
    names(y) <- head(LETTERS,length(y))
    y
})#gdp代號配對

#接下來透過translation把資料挑出來分類
power.df2 %<>% mutate(id2 = translation.power[id])
#translation.power[id]意思是translation.power[power.df2$id]
#power.df2的id各自對應到translation.power的數字
power.df3 <- power.df2[complete.cases(power.df2$id2),] %>% #刪除NA值
    group_by(year,id2) %>%
    summarise(power = sum(power),name = paste(name,collapse = ","))
#I及J被歸類在一塊，使用paste黏合
#整理出每年每種產業的耗能總和

#GDP
gdp.df2 %<>% mutate(id2 = translation.gdp[id])
gdp.df3 <- gdp.df2[complete.cases(gdp.df2$id2),] %>%
    group_by(year,id2) %>%
    summarise(gdp = sum(gdp))
#每年每種產業的gdp總和

#觀察兩筆資料發現年份還沒有對應，找出兩筆資料'共同'的年份
power.gdp <- inner_join(power.df3,gdp.df3,by = c("year","id2")) %>%
    mutate(eff = gdp/power) %>%
    as.data.frame() #需要轉為df才能餵給ggplot2
#挑出每年每個id的power和gdp還有eff效率值



##R最後關卡答案，好像錯誤？

#' 請同學自由發揮
#' 我們只將結果的條件已`stopifnot`的方式寫在最下方給同學參考
power.gdp <- local({
    power.df3 <-
        power.df2 %>%
        mutate(id2 = translation.gdp[id]) %>%
        filter(!is.na(id2)) %>%
        group_by(year, id2) %>%
        summarise(power = sum(power), name = paste(name, collapse = ","))
    
    gdp.df3 <- 
        gdp.df2 %>%
        mutate(id2 = translation.gdp[id]) %>%
        group_by(year, id2) %>%
        summarise(gdp = sum(gdp))
    
    power.gdp <- inner_join(power.df3, gdp.df3, c("year", "id2")) %>%
        mutate(eff = gdp / power) %>%
        as.data.frame()
    # 請在此填寫你的程式碼
})



