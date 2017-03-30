#XML (eXtensible Markup Language) , HTML(Hyper Text Markup Language)
#大部份網站會採用HTML或XML，兩者相輔相成
#HTML用來描述顯示網頁，把數據和顯示的東西混在一起
#XML則用來分開數據和顯示的東西，類似整理的功能
#<H1>abc</H1> HTML的H1表示首行標題為abc，<>有標籤的作用
#<87>你</87> XML的<>可以自訂標籤，“/”表結束記號
#XML的主要功能在於強化HTML
#<tr>                             
#     <th>123</th> 
#     <td>456</td>
#</tr>             'tr'代表父標籤，'th','td'代表子標籤
#接下來介紹如何挖掘資料，常見的網頁都會有成千上萬的標籤
#通常在‘找標籤’這個過程最為費工。
#在xml2套件中，標籤分為xml_document(整個文件),xml_nodeset(標籤集合),
#xml_node(標籤)
#介紹xml2套件中xml_find_all功能
x <- read_html("http://pttweb.tw/thread/m-1481859660-a-eaf") 
#這是ptt上隨便找的一篇文章，網頁會經由read_html做成xml_document物件
#當我們獲得xml_document(整個文件)時，就能從XPath中抓取nodeset
xml_view(x, add_filter = TRUE)
#透過xml_view將xml_document輸出，add_filter = TRUE代表輸出一個
#表格到右下視窗Viewer，如果 = FALSE，沒辦法進行XPath搜尋，
#無法清楚看出整個樹狀結構，一不小心還會覆蓋原有coding紀錄
#上面的XPath就是用來搜尋
#//span[@class="f3 push-content"]，輸入這樣的格式可以萃取資訊
#接下來按一下R的pattern，會出現專屬R的code
xml2::xml_find_all(x, '//span[@class="f3 push-content"]', ns=xml2::xml_ns(x))
#xml_find_all的功能如上，x代表你的xml_document，xpath是你想搜尋的資料
#最後一項ns則是以xml_ns功能，顯示以xml格式的字串向量
z <- read_html("http://pttweb.tw/thread/m-1481859660-a-eaf")
xml_text(z) #顯示內容，但是z參數限制是xml_document，輸出為字串向量
xml_parent(z) #取出z的父標籤，理解為回到父層
xml_contents(z) #輸出為nodeset
xml_children(z) #取出以z為nodeset的node，理解為進到子層
xml_attrs(z) #找出attributes
xml_find_all(z,"//html[@lang]", ns=xml2::xml_ns(z)) #找出attrs就能寫出後面的xpath


#這裡為本人自己對習題後面所做的處理，處理掉\r\t\n的部分
trs_children_text <- xml_text(trs_children)
players <- trs_children_text!="　廠商名稱"
goal <- trs_children_text[players]
library(stringr)
goal <- str_trim(goal, side = "right")
goal <- str_trim(goal, side = "left")
goal
