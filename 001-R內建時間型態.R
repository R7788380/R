#在R內建裡提供兩種類型的時間數據
#第一種為Date是日期數據(年日月)，不包含時間和時區，儲存天
#第二種為POSIXct/POSIXt數據，POSIXct儲存秒，POSIXlt把時間分成年月日時分秒
#日期固定格式年月日中間為'-'或'/'，時分秒為':'，日期與時間中間要空格
a <- c("2017-01-11 7:00:00") #型態為字串
as.Date(a) #轉換成Date型態，因為只有儲存年月日，所以時分秒被忽略了
unclass(as.Date(a)-as.Date(c("1970-1-1"))) #以天數儲存，R定義1970/1/1第0天 
as.Date(c("11-01-2017")) #有些日期不是按照年月日去排列，輸出不是我們想要的
as.Date(c("11-01-2017"),format = "%d-%m-%Y") #透過format自訂時間格式
# %d日、%m月、%Y西元年4位數、%y民國年2位數、%B 1月、%b 1(沒有0)、
#%D日/月/年(2位數)、%A週三、%a三、%u 3、%F格式2017-01-11、%H小時(24h)、
#%I小時(12h)、%j年初到現在總天數、%M分鐘、%p上下午、%r 時:分:秒 上下午
#%R時:分(24h)、%T時:分:秒(24h)、%U一年中第幾週(禮拜日為第一天)、%S 秒數
#%V一年中第幾週(禮拜一為第一天)、%x格式2017/01/11、%X格式20時30分30秒
#%z+8:00時區、%Z時區 
as.POSIXct(a) #顯示年月日時分秒，POSIXct會自己
unclass(as.POSIXct(a)) #POSIXct儲存秒
as.POSIXlt(a) #一樣以CST時間為準
unclass(as.POSIXlt(a))#POSIXlt分成秒分時日月年,禮拜幾,一年中第幾天,時區

Sys.time() #Sys.time目前系統時間，出現年月日時分秒以及時區CST
#zone時區分為GMT格林威治標準時間、UTC世界協調時間、DST夏日節約時間
#CST又分成4個時區：(USA)UT-6:00、(Australia)UT+9:30、(China)UT+8:00、
#(Cuba)UT-4:00
#目前以UTC世界協調時間被廣泛使用

#介紹時間運算，計算時間差，同Date或同POSIXct,POSIXlt才能相減
difftime(as.Date(a), Sys.time(), units = "days")#不同型態時間都可以計算
#units預設auto,還有secs,mins,hours,days,weeks，不能算年月季時間差
format(Sys.time(),format = "%Y-%m-%d %H:%M:%S") #指定出現格式
#注意format出來格式是character，不是時間型態
strptime(a, format = "%Y-%m-%d") - strptime(Sys.time(), format = "%Y-%m-%d")
#strptime轉換成POSIXct和POSIXlt型態，所以可以相減
#注意strptime後面format要根據前面參數來設定，不能指定format
strptime(Sys.time(), format = "%Y-%B-%d")
#會出現NA，代表format指定不正確
strptime(Sys.time(), format = "%Y-%m-%d %H:%M:%S")
#正確格式

#由出生年月日知道年紀 輸入格式 : "1996-2-1"
timeformat <- function(x){
     a <- difftime(Sys.time(), as.Date(x), units = "days")
     round(a/365,digits = 0) %>%
         as.character() %>%
         paste0(" olds")}

library(lubridate) #轉換時間型態套件
?parse_date_time
parse_date_time("2017 1 1 11 11 10", orders = "ymd HMS") 
#x參數為字串向量或是數值向量，orders是指定轉換的格式，內建tz以UTC
#x參數的格式只要跟後面orders配合即可，不用打'-'或'/'或':'
parse_date_time("11 11 10 17 1 1",orders = "HMS ymd")
#不管x參數如何排列，orders配合得宜就能輸出
#輸出格式一律是:西元年-月-日 時:分:秒 tz
parse_date_time("17 1 1",orders = "ymd")
parse_date_time("1 17 1",orders = "myd")

#還有另一種方式，不用每次都打出parse_data_time
#通常一筆資料時間的排序格式都是固定的，例如2017-01-01 10:50:30
?ymd_hms #一樣根據時間排序的函數
#還有mdy,dmy,ymd_h,dmy_hms等等一大堆，照自己時間格式即可
ymd_hms("2017-1-1 10:50:30")

#遇過一種情況，當df的時間以col分開該怎麼辦？
library(nycflights13) #我們要拿裡面的flights資料集做例子
View(flights) #裡面的年月日是分別放在各個表格
time <- na.omit(flights)
paste0(time$year,"-",time$month,"-",time$day," ",
       time$hour,":",time$minute) %>% ymd_hm()
#使用字串黏合即可






