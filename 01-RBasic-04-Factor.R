#Factor 儲存類別資料，例如：男女，大小，高低，高矮
#Factor 顯示出型態為numeric的元素以及levels
#使用X[1] <- "Y" 指派factor(X)中levels沒有的類別，輸出X之後第一位會出現NA
#str() 顯示數據結構及內容
#str(x)  Factor w/ 4 levels "A","AB","B","O": 3 1 1 4 NA 4 1 2 4 2 ...
#表示Factor向量中有4個levels:"A","AB","B","O"以及對應的levels
#無法比較的資料，factor會輸出警告訊息 NA，例如：血型，縣市
#可自訂levels的順序，factor(x, ordered = TRUE, levels = c("A","AB","O"))
#使用ordered=TRUE顯示出讓R知道要進行排序，levels用來設定大小位置
#輸出Levels: A < AB < O
#排序出levels等第之後，就能進行比較，x[1]>x[2]