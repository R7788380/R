#JSON (JavaScript Object Notation)  在JavaScript中，表示物件的一種格式
#JSON跟XML一樣都是應用於Web應用開發，但是JSON已經逐漸代替了XML
#JSON是以’純文字’為基底來儲存及傳送資料
#以特定的結構(陣列,字串,數字,物件)，所以能非常簡單的跟其他程式進行溝通
#<http://www.jsoneditoronline.org/>這是JSON的format
#物件用{}大括號,陣列用()小括號，就算是初學者也能馬上了解
#不像XML一堆Node難以判讀，儘管有XPath來輔助個人還是覺得JSON格式看的較舒服
#<http://www.tutorialspoint.com/online_xml_editor.htm>這是XML的format
#有進行上一章XML就知道要爬出自己需要的資料有多麻煩
#但是並不說明JSON較XML有絕對的優勢
#雖然XML在判讀上比較麻煩，但是在資料儲存,擴充,檢索方面還是XML佔優
#格式方面，XML一堆Node會讓資料量過於龐大，使得傳輸速度變慢
#但是JSON只需{}()就能表達，所以小巧而適用於傳輸領域
cat(facebook_error, sep = "\n") #cat()函數輸出沒有換行符'\n'，需要自行輸入
#當然沒有\n也可以 ，將結果複製下來丟到上面JSON網址一樣可以輸出
library(jsonlite) #接下來介紹JSON套件
vignette(package = "jsonlite") #先使用vignette()來查看附加文檔列表
vignette("json-aaquickstart", "jsonlite") #開啟文檔
#文中範例充分說明了jsonlite套件的功能
x <- jsonlite::fromJSON("http://data.taipei/youbike")
#這是台北youbike的開放資料
#fromJSON()會輸出適合的物件，建議設個變數，不然會蓋掉code紀錄
z <- c(1,"皓呆",FALSE,1.2,1+3i)
jsonlite::toJSON(z) #toJSON()會轉換成JSON物件
y <- c(1,2,3); z <- list(1,2,3)
all.equal(y,z) #all.equal()用來檢測y,z是否'一模一樣',否則會回傳理由


