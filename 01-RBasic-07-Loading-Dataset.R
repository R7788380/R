library(help = "datasets") #列出R內建資料集
data(iris,package = "datasets")  #data()載入資料集
data("iris") #也行
head(iris) #列出前幾筆資料，預設6筆，可自行選擇
head(iris,3) #列出前3筆
tail(iris) #列出後幾筆資料，預設6筆
#iris鳶尾花資料集是一個data.frame，大部份的資料集都是以data.frame呈現
iris <- 1 #當函數data()載入某資料集，該資料集名稱就不能再被賦值
colnames(iris) #colnames()取出欄位名稱
rownames(iris) #rownames()取出列位名稱
dimnames(iris) #dimnames()取出欄位和列位名稱

#從外部輸入資料時，最基本的要求是知道資料是否有位元順序記號BOM
#知道BOM就能知道資料的編碼 <https://goo.gl/4rsn4q>
readBin(data = x, what = "raw", n = 3) # ?readBin
#data檔案路徑，what = ""輸出的模式，n = 輸出行
#基本上位元都會出現在前三個，再對照編碼即可
#如果位元沒有出在表上，代表沒有資料集沒有BOM
#沒有出現在表上的編碼基本上都可猜測是BIG5
#大部份台灣的opendata都是使用BIG5，因為早期台灣幾乎都使用windows來進行資料存取
#知道編碼之後，就能進行測試，測試編碼到底對不對
readLines(file(x,encoding = "BIG5"),n= 1)
#知道編碼後看輸出就能知道各欄位的分隔符號
#通常csv檔的分隔符號為','，根據資料裡的符號判斷
?readLines #請參照說明，就知道為何要先使用file()函數
#說明中readLines要讀取的必須是從一個Connection來進行讀取
#所以才要使用file()來建立Connection，並且輸入編碼encoding = ""
#讀取完可能會出現”關閉未使用的連結“這警告訊息，這是因為R的內存釋放的關係
x.info <- file.info(x) #file.info()查看目錄資訊，會顯示大小(size)等等資訊
x.info$size #主要是想要知道檔案到底有多大 n
x.bin <- readBin(x, what = "raw", n = x.info$size)
#因為readBin()中預設n = 1，所以必須知道資料集到底多大
#知道大小之後就能列出所有資料，記住這裡還是raw型態
library(stringi)  #請參照 ?stringi 這裡只介紹其中轉換編碼功能
x.txt <- stri_encode(x.bin,"BIG5","UTF-8")
#將raw從BIG5轉換至UTF-8
read.table() #此函數最常用來進行多變數資料輸入，用來輸入.csv及.txt檔案
read.table(x,fileEncoding = "BIG5",header = TRUE,sep = ",")
#fileEncoding只能接受character進行重新編碼
#header = TRUE說明資料是否含有欄位名稱，sep = ""符號由上面readLines輸出判斷
read.table(file(x,encoding = "BIG5"),header = TRUE,sep = ",")
#此種方法也可
l10n_info() #此函數是用來查詢作業系統對Encoding的支援狀況
#MBCS表示支援多位元組字串  ζχψωβνασδφ 以及UTF-8的支援

#整理：大部分的資料只要能夠知道資料的編碼及notation，就能夠使用read.table來輸出資料
