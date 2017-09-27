#由上一章節Dataset知道如果readBin輸出的BOM是我們所不知道的時候，
#就要靠經驗才猜測，大部份台灣資料都是windows輸出，所以猜測BIG5
#PS.政府的OPENDATA上面有部分資料宣稱資料是由UTF-8編碼，其實都是BIG5
x_times <- x$times #大部份的資料都是龐大的，所以建議先令變數再輸出成表格
#一來Console的空間可以省下來，不會蓋掉coding紀錄
#二來令變數之後由右邊的Environment可以直接呼叫出表格，不會給R造成負擔
substr("12345",1,3) #此函數可以截取字串中的元素，輸出為"123"
substring("12345",1,3) #此函數也是輸出"123"
#兩者差在哪呢？
substr("123",2) #substr()函數一定要設定start和stop值，否則輸出為Error
substring("12345",1) #substring()會從start的值開始跑，直到最後一位
#substring可以自由的設定stop值，所以通常都習慣使用substring

?strsplit #接下來看strsplit的 x 參數說明，輸入須為character vector
#代表要使用此函數前都要使用as.character()來轉換為字串
#as.開頭，代表轉變or建立的意思
#is.開頭，是判斷是否為想要的型態，是的話TRUE，否則則是FALSE
strsplit("123",split = "2") #此函數可以忽略split = ""的值
strsplit("1.2.3",split = ".",fixed = TRUE)
#此函數使用上需要注意，有時候我們要忽略的split是正規表示式
#<https://goo.gl/rlXfJK>，忽略正規表示式要設定fixed = TRUE
#fixed是用來判斷split是否是正規表示式，預設為FALSE
#strsplit輸出為list型態，請小心選取[[]],[]

#接下來介紹apply()函數家族
x <- matrix(1:10,2,5)
apply(x,MARGIN = 1,mean);apply(x,MARGIN = 2,mean, na.rm = T)
#apply()表示要對 x 這筆資料用 mean 進行運算
#MARGIN = 1表示逐列運算 , = 2表示逐行運算，輸出值為vector
#當然資料中也許有NA，這時使用na.rm = T來進行迴避
#不過忽略掉NA可能會造成NA的那一行列的值沒有計算到，需特別注意
#後面的 FUN 參數可以自訂
lapply(x,mean)
#lapply()函數輸出為list，其實從lapply的'l'來判斷就好，很簡單
sapply(x,mean)
#sapply()函數輸出較為簡單，通常是vector或是matrix
lapply(x, is.matrix);sapply(x, is.matrix)
#這裡請注意，輸出以上函數會出現全部都是FALSE的情況
#這是因為apply家族是針對'裡面的元素'進行function的運算，而不是x整體
is.matrix(x) #直接使用判斷式is.，反而更簡單
#到了這裡，課程中會介紹比較少見的語法
lapply(x, "[", 1) #抽取出x中每個元素的第一個欄位
lapply(x, function(x)) #透過自訂function來進行運算

