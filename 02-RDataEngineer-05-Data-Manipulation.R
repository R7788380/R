#上一章介紹對資料庫進行存取的套件，內容型態為data.frame
#這章則介紹對data.frame進行更近一步的整理
#dplyr套件是針對大型資料編輯的利器
install.packages("dplyr");library(dplyr) #先安裝並載入套件
vignette(package = "dplyr") #開啟vignette來閱讀附加文檔，裡面充分介紹dplyr套件
vignette("introduction", package = "dplyr")
#其中以nycflights13這套件中的flights的資料集作為範例
install.packages("nycflights13"); library(nycflights13) #請先載入資料集

filter(flights, month == 1, day == 1) #filiter函數能針對df做過濾的動作
filter(flights, month == 1 & day == 1) #也可以使用條件組合&,|
#後面參數自訂月份==1,日期==1，做'row'的篩選
#不管是tdl_df,tdl_dt，只會列出一部分資料，輸出太多資料電腦可能會GG
#要更改輸出數量請愛惜使用 print(x, n = 5) 輸出5row
flights[flights$month == 1& flights$day == 1,]#fliter等價於這expression
flights %>% filter(month == 1, day == 1)

arrange(flights, dep_delay) #arrange會根據你選定的變數做排列，可以是多個變數
#arrange預設由小排至大
arrange(flights, desc(dep_delay))#可用desc來做出由大至小

x <- mutate(flights, adc = substr(year, 3, 4))
#mutate會根據給予的值adc賦予df新變數，也可以覆蓋舊變數

select(flights, year, dep_delay)
select(flights, year:day)
#select會根據給予的參數挑選col，也可以進行排除
select(flights, desc(year:day))

flights_x <- flights %>% group_by(month) %>% 
    summarise(arr_mean = mean(arr_time, na.rm = TRUE),arr_times = n())
#group_by函數能夠依據參數條件分類
#summarise總結出flights 1~12月的arr_times平均和次數

#接下來介紹字串處理函數grep家族
?grep; grep("AA", flights$tailnum) #找出字串中含有AA的元素，傳回位置向量
grep("AA", flights$tailnum, value = TRUE) #value = TRUE會顯示出值
grep("AA", flights$tailnum, value = TRUE, invert = TRUE)
#invert = TRUE表示顯示除了含有AA以外的元素
grepl("AA", flights$tailnum) #跟grep類似，只是傳回的為布林向量
x <- c("AABBCC")
sub("A", replacement = "G", x)#取代第一個字串
gsub("A", replacement = "G", x)#全部取代

#可以將dplyr與grep結合使用
#由grepl選出tailnum中含有AA的元素回傳布林向量並讓filter對df做挑選
filter(flights, grepl("AA", flights$tailnum, fixed = TRUE))
flights %>% filter(grepl("AA", tailnum, fixed = TRUE))
#注意，grepl針對的是字串向量而不是df
?slice ; slice(flights,1:6) #slice挑選1~6row的元素
flights[1:6,]#等價
slice(flights, desc(1:6)) #desc是個很好用的函數
flights[-(1:6),]#等價

distinct(select(flights, year:day)) #distinct過濾去重複的值
unique(select(flights, year:day)) #一樣可以過濾重複的值
#過濾的值是以最後一欄為標準來過濾重複的值

#當資料很大時，我們需要透過抽樣來抓取資料判斷資料趨勢
sample_n(flights, size = 10) #隨機抽取10row
sample_frac(flights, size = 0.01) #隨機抽取母體*0.01數量的row，size為比率
sample(flights,10) #直接使用sample會連col都一起隨機抽樣，沒意義
sample_n(flights, size = 10, replace = TRUE)
#說到抽樣當然會講到取後放不放回，replace = TRUE為取後放回

#pipeline operator寫法，就是把前面的值帶入後面函數的第一個參數
seq(1,9) %>% sum() #注意%>%這符號不是R內建函數而是dplyr套件的函數



