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
filter(flights, month == 1, month == 2) 
#上式輸出會空白，因為R會理解為month=1中month也等於2的，不可能
filter(flights, month == c(1,2)) #使用向量來選取month同時是1和2
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

xs <- data.frame(x = c(1,1,2,2), y = c(1,1,2,2), 
                z = c(1,1,2,2), sum = c(5,6,7,8)) 
group_by(xs,x,y,z) %>%
    summarise(sums = sum(sum)+sum) 
#error會顯示expecting a single value，因為summarise每個子節只能有一個值，
#如果groupby完之後sum(sum)+sum的第一row會跑出兩個值16,17
#而第二row則是22,23
group_by(xs,x,y,z) %>%
    summarise(sumx = sum(sum))
#注意函數的使用會不會造成多個值或單一值
group_by(xs,x,y,z) %>%
    mutate(sumz = sum(sum)+sum)
#mutate則是固定原來row數，新增或覆蓋一個col，輸出結果

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
"AAA" %>% grepl(pattern = "A") 
#當使用%>%傳回的值若不是在第一個參數時，使用函數內指定參數，R會判斷輸入第二個參數
grepl("^p.",c("pppp","peeee","eeeep")) #找出開頭是p的字串
grepl("p$",c("pppp","peeee","eeeep")) #找出結尾是p的字串
grepl("^p.*e$",c("pppp","peeee","eeeep")) #p開頭e結尾的字串
grepl("[123]",c("1234","pee3e","eeeep")) #元素中有1或2或3的字串
grepl("[ep]",c("pppp","peeee","eeeep")) #同理，有e或p的字串
grepl("[0-9]",c("1234","pee3e","eeeep")) #元素中有0~9其中之一的字串
grepl("\\d",c("1234","pee3e","eeeep")) #等價，\\d等於[0-9]
grepl("[a-z0-9]",c("1234","pee3e","eeeep")) #含字母或數字的字串
grepl("p[3e]e",c("1234","pee3e","eeeep"))#字首p結尾e中間為3或1的字串
grepl("[^0-9]",c("1234","peee","eeeep")) #'^'不含0~9其中之一的字串
grepl("\\D",c("1234","peee","eeeep")) #等價，\\D等於[0-9]
grepl("[/^]",c("1234","pee^3e","eee^ep")) #有"^"的字串
grepl("\\s",c("1234","pee^3 e")) #含有空白字元[ \r\t\n\f]
grepl("[ \r\t\n\f]",c("1234","pee^3 e")) #空白字元，等價
grepl("\\w",c("1234","小明")) #等價[0-9a-zA-Z]
grepl("\\W",c("1234","小明")) #等價[^0-9a-zA-Z]
y <- c("abcdefg", "abcdefh")
grepl("abcdef(g|h)",y) #對於大型資料好用，找出abcdef開頭，後面是g或h的字串


x <- c("AAB BCC   ")
sub("A", replacement = "G", x)#取代字串中第一個出現A的字
gsub("A", replacement = "G", x)#A全部由G取代
sub(" ",replacement = "",x) #消除第一個空白
gsub(" ",replacement = "",x) #消除所有空白

#可以將dplyr與grep結合使用
#由grepl選出tailnum中含有AA的元素回傳布林向量並讓filter對df做row挑選
filter(flights, grepl("AA", tailnum, fixed = TRUE))
flights %>% filter(grepl("AA", tailnum, fixed = TRUE))
#注意，grepl針對的是字串向量而不是df
?slice ; slice(flights,1:6) #slice挑選1~6row
flights[1:6,]#等價
slice(flights, desc(1:6)) #挑選除了1~6row之外的
flights[-(1:6),]#等價

distinct(select(flights, year:day)) #distinct過濾去重複的值
unique(select(flights, year:day)) #一樣可以過濾重複的值
#過濾的值是以最後一欄為標準來過濾重複的值
#unique可以針對向量或是data.frame裡面的欄位
unique(c(1,1,1,1,3,3,3,4)) #可使用
distinct(c(1,1,1,1,3,3,3,4)) #不能用
#但是distinct只能對data.frame裡面多個欄位使用
distinct(iris,Species,Petal.Width) #指定條件


#當資料很大時，我們需要透過抽樣來抓取資料判斷資料趨勢
sample_n(flights, size = 10) #隨機抽取10row
sample_frac(flights, size = 0.01) #隨機抽取母體*0.01數量的row，size為比率
sample(flights,10) #直接使用sample會連col都一起隨機抽樣，沒意義
sample_n(flights, size = 10, replace = TRUE)
#說到抽樣當然會講到取後放不放回，replace = TRUE為取後放回

#pipeline operator寫法，就是把前面的值帶入後面函數的第一個參數
seq(1,9) %>% sum() #注意%>%這符號不是R內建函數而是dplyr套件的函數

DF_list = replicate(5, data.frame(cat1 = sample(c("A", "B"), 5, 1),
                                  cat2 = sample(c(1, 2), 5, 1), v = rnorm(5)), simplify = FALSE)
#重複5個list，接下來對5個list合併成一個data.frame
bind_rows(DF_list) #dplyr函數，以rows合併
do.call("rbind",DF_list) #等價

bind_cols(DF_list) #以cols合併
do.call("cbind",DF_list) #等價
#在某些情形do.call(rbind,)和bind_rows不是通用的，還沒找出原因，兩種都嘗試看看

trunc(c(-1.2,-1.5,1.5)) #取整數
ceiling(c(-1.2,-1.5,1.5)) #大於x的最小整數
floor(c(-1.2,-1.5,1.5)) #小於x的最大整數
round(c(-10.5,-11.5,10.5,11.5))
#四捨六入五保留，遇到5時，看前一位是什麼，奇進偶不進

