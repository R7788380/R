#關聯式資料庫 (RD , Relational database)
#(個人感覺就是比data.frame更多功能的一種list)
#只是愈龐大的資料就愈要求效能,整合度等等，還有最重要的安全性
#如SQLite, MySQL, PostgreSQL等等
#介紹使用R來對資料庫進行連線,讀取,寫入,更改,刪除功能
install.packages("RSQLite") #首先安裝RSQLite套件
library(RSQLite) #因為要和SQLite資料庫溝通，所以直接安裝RSQLite
library(DBI)  #在R中可以透過DBI套件中的函數進行資料庫存取
?dbDriver; drv <- dbDriver("SQLite") #取得連結'SQLite'資料庫的方式
?dbConnect; db <- dbConnect(drv, db_path) #建立一個在R中的SQLite資料庫連結
#之後要對db_path這路徑的資料庫存取，就必須透過db來當代理
help.search("dbWriteTable")
#進去會看到2種不同資料庫的dbWriteTable函數，而swirl選擇使用SQLite資料庫
#注意，不同的資料庫在R中不一定有提供類似的功能
#例如較新版SQL在R中的DBI或許就沒有MySQL成熟的功能
dbWriteTable(db, "lvr_land2", lvr_land)
#將lvr_land的數據以lvr_land2的名稱輸入db連結的SQLite
#注意，一個name只能在同樣的db存在一個，再次輸入上式會error
lvr_land2 <- data.frame(lvr_land) #感覺就像這樣，只是輸入的地方不同
dbWriteTable(db, "lvr_land2", lvr_land, overwrite = TRUE)
#使用overwrite可以覆蓋同屬性的值，返回值為布林
dbWriteTable(db, "lvr_land2", lvr_land, append = TRUE)
#append = TRUE會直接把值接在同屬性的表格之下
dbWriteTable(db, "lvr_land2", lvr_land, overwrite = TRUE, append = TRUE)
#當然overwrite和append不可能同時存在
dbListTables(db) #dbListTables()列出目前db裡面的表格
iris2 <- dbReadTable(db, "iris") #知道了裡面的表格就能進行讀取
#一樣養成假設變數的習慣，直接點Environment呼叫出data.frame來觀察
all.equal(iris, iris2) #輸出發現Species的型態改變了
mode(iris2$Species) #從factor改變為character
#會這麼做的原因應該是希望萃取出來的資料可以直接透過stringi等套件進行整理
#dbWriteTable和dbReadTable都是拿出db裡面一整個表格
dbGetQuery(db, "SELECT * FROM iris WHERE species = \"virginica\"")
?dbGetQuery #Arguments和Examples有說明，後面需接上SQL語法
#後面的 \"virginica\"" 為跳脫字元，若字串中有包含單雙引號時使用
dbGetQuery(db, 'SELECT * FROM iris WHERE species = "virginica"')
#也可以使用單引號包覆雙引號，或雙引號包覆單引號
rs <- dbSendQuery(db, "SELECT * FROM iris")
#使用dbSendQuery的結果是SQLite，還不是data.frame
fetch(rs,n = 1) #fetch只接受DBIResult，n = 1表示印出一列，n = -1印出全部
fetch(rs,n = 1) #再次輸入fetch會出現不一樣的結果
#這是因為當主鍵被選取時，下一個候選鍵會出來當主鍵
#dbGetQuery和dbSendQuery&fetch輸出都是data.frame，可使用data.frame的選取方式
#當資料庫龐大時，使用dbSendQuery&fetch來選取資料是很有效的
dbClearResult(rs) #當不需要時就刪除，不然會佔內存
#有時會因為某些原因導致電腦秀逗甚至是中斷連線
#我們當然不希望資料庫讀到一半就跳掉，所以db有transaction功能
#transaction確保我們的資料庫處於全部執行成功,全部不執行的狀態
#若只執行一部分資料，會造成資料異常
dbDisconnect(db) #先中斷連線
db <- dbConnect(drv, db_path) #建立連線
dbBegin(db) #使用dbBegin來開啟Transaction，保留原始狀態
dbRemoveTable(db, "CO2") #假設資料庫執行到一半，將CO2刪除
dbDisconnect(db) #中斷db連線，模擬意外狀況
db <- dbConnect(drv, db_path) #重新連線
dbListTables(db) #CO2回來嚕
dbRollback(db) #使用dbRollback把資料庫還原成執行dbBegin的時候
dbCommit(db) #讓dbBegin之後的變更生效
dbClearResult(rs) #清除rs(DBIResult)

#從dbBegin(db)開始更改過的資料庫，dbCommit()會結尾並直接修改資料庫
#再使用dbRollback()也沒辦法回復成dbBegin()的狀態
#dbRollback(db)配合dbBegin(db)使用



