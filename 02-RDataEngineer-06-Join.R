#當整理完資料後，一定要進行的步驟：資料比對
#當比對2個df的時候，我們會希望資料能夠一目瞭然哪裡不同哪裡相同
x <- data.frame(A1 = c(1,2,3,"NA","提摩"), A2 = sample(c("77","87","97"),5,1),
                B = gamma(5),stringsAsFactors = FALSE)
y <- data.frame(A1 = c(1,2,3,"NA","提摩"), A2 = sample(c("77","87","97"),5,1),
                B = gamma(6),stringsAsFactors = FALSE)
#data.frame參數會預設字串為因子，請設定FALSE，因為函數處理大多以字串為主
merge(x, y, by = c("A1", "A2")) #merge會根據by值來挑選x和y相同的元素
merge(x, y, by = c("A1", "A2"),all.x = TRUE)#挑出且保留x所有的值
merge(x, y, by = c("A1", "A2"),all.y = TRUE)#挑出且保留y所有的值
merge(x, y, by = c("A1", "A2"),all = TRUE)#全部保留
#by參數一定要x,y同時有，如果沒有設定by參數則預設挑出相同的colname來比較
#撞名則在後面加.x,.y，比較完by之後，x中的B.x有而y中的B.y沒有的元素會顯示NA
#all所保留的元素，如果by參數A1,A2的元素中有NA，merge會自動排到最下面
#接下來介紹dplyr套件，其中也有類似merge功能的函數，只是排列略有不同
inner_join(x,y,by = c("A1")); merge(x, y, by = c("A1"))
#請比較這兩者的不同，inner_join不會對資料做排列而merge會
#在處理資料的時候，有時我們需要挑出NA值，或是不允許資料隨意更動
#依照不同需求而使用不同函數
left_join(x,y,by = c("A1","A2")) #功能與all.x = TRUE一樣，左聯集
right_join(x,y,by = c("A1","A2")) #all.y = TRUE，右聯集
full_join(x,y,by = c("A1","A2")) #all = TRUE，聯集
anti_join(x,y,by = c("A1","A2")) #x扣掉x,y的交集
semi_join(x,y,by = c("A1","A2")) #inner_join中只保留x的元素
#一樣如果沒有設定by參數則預設挑出相同的colname來比較
z <- data.frame(A3 = c(1,2,3,"NA","提摩"), A4 = sample(c("77","87","97"),5,1),
                B = gamma(5),stringsAsFactors = FALSE)

inner_join(x,z,by = c("A1" = "A3", "A2" = "A4"))
#join如果變數名稱不一樣該怎麼辦？直接輸入要相互比較的名稱"A1" = "A3"...
merge(x,z,by.x = c("A1","A3"),by.y = c("A2","A4"))
#merge則是設定by.x和by.y

na.omit() #比較完整的資料應該都有NA值，這函數可以將有NA值的row全部刪除

intersect(colnames(x),colnames(y))#intersect會列出兩個df交集的元素
all.equal(colnames(x),colnames(y))#直接顯示出哪裡不同
union(x,y) #有相同的colnames才可以合併
union_all(x,z) #強制合併，不同的colnames則顯示"NA"
setdiff(x,y) #比較兩者不同的row，輸出x中不同的row
setequal(colnames(x),colnames(y)) #比較兩者是否不同，輸出布林值

fivenum(c(1,2,3,4)) #輸出最大最小值以及第'一,二,三'四分位數
#輸出為數值向量
quantile(c(1,2,3,4)) #一樣輸出最大最小值及四分位數
#輸出會清楚表示0% 25% 50% 75% 100%的位置
x <- quantile(c(0,1,2,3,4)) #如何對數值依照四分位距做分級
cut(c(0,1,2,3,4), breaks = c(x[1]-1e-2,tail(x,-1)),labels = c("A","B","C","D"))
#cut()會依照breadk中進行區分，labels可以進行標籤，觀察規律
cut(c(0,1,2,3,4), breaks = c(x[1]-Inf,tail(x,-1)))
#拿3做例子 2 < 3 <= 3，3被分在(2,3]這一組，所以0是位於(-Inf,0]這一組
#而不是分在(0,1]這組，所以我們要將最小分位往後扣一點，0才能夠被分級
cut(c(0,1,2,3,4), breaks = (x)) #如果沒有往後分級，0則會被分成NA值

#匹配函數match
x <- 10:20
j <- c(7,9,11,13)
match(j,x) #顯示j中的element在x的位置向量，沒有則顯示NA
match(x,j) #跟上式不一樣，顯示x中的element在j的位置向量

