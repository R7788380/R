# 這是從 <http://data.gov.tw/node/7769> 下載的海盜通報資料
# 由於這份文件並沒有遵循任何已知的常見格式
# 所以我們必須要利用這章所學的技巧
# 才能從中翠取出資訊
# 首先，我們把該檔案載入到R 之中
pirate_info <- readLines(file(pirate_path, encoding = "BIG5"))

# 接著我們要把經緯度從這份資料中萃取出來
# 這份資料的格式，基本上可以用`：`分割出資料的欄位與內容
# 請同學利用`strsplit`將`pirate_info`做切割
# 並把結果儲存到`pirate_info_key_value`之中
pirate_info_key_value <- {
    x <- strsplit(pirate_info, split = "")[[59]][5]
    strsplit(pirate_info, split = x)
}

# 我們需要的欄位名稱是「經緯度」
# 請同學先把`pirate_info_key_value`中每個元素（這些元素均為字串向量）的第一個值取出
# 你的答案鷹該要是字串向量
pirate_info_key <- {
    sapply(pirate_info_key_value, "[", 1)
}

# 確保你的結果是字串向量，否則答案會出錯
stopifnot(class(pirate_info_key) == "character")

# 我們將`pirate_info_key`和`"經緯度"`做比較後，把結果存到變數`pirate_is_coordinate`
# 結果應該為一個布林向量
pirate_is_coordinate <- {
    pirate_info_key=="經緯度"
    
}

# 確保你的結果是布林向量，否則答案會出錯
stopifnot(class(pirate_is_coordinate) == "logical")
# 應該總共有11件海盜通報事件
stopifnot(sum(pirate_is_coordinate) == 11)

# 接著我們可以利用`pirate_is_coordinate`和`pirate_info_key_value`
# 找出所有的經緯度資料
# 請把這個資料存到變數`pirate_coordinate_raw`中，並且是個長度為11的字串向量
pirate_coordinate_raw <- {
    x <- pirate_info_key_value[pirate_is_coordinate]
    sapply(x, "[", 2)
}

stopifnot(class(pirate_coordinate_raw) == "character")
stopifnot(length(pirate_coordinate_raw) == 11)

# 我們接著可以使用`substring`抓出經緯度的數字
# 請先抓出緯度並忽略「分」的部份
# 結果應該是整數（請用as.integer轉換）
pirate_coordinate_latitude <- {
    x <- substring(pirate_coordinate_raw,3,4)
    as.integer(x)
}

stopifnot(class(pirate_coordinate_latitude) == "integer")
stopifnot(length(pirate_coordinate_latitude) == 11)
stopifnot(sum(pirate_coordinate_latitude) == 43)

# 請用同樣的要領取出經度並忽略「分」的部份
# 結果同樣應該是整數
pirate_coordinate_longitude <- {
    y <- substring(pirate_coordinate_raw,12,14)
    as.integer(y)
}

stopifnot(class(pirate_coordinate_longitude) == "integer")
stopifnot(length(pirate_coordinate_longitude) == 11)
stopifnot(sum(pirate_coordinate_longitude) == 1151)

# 為了方便後續的分析，我們常常把非結構化的資料整理為結構化資料。
# 在R 中，結構化的資料結構就是data.frame
# 請同學利用上述的數據，建立一個有11筆資料的data.frame
# 其中有兩個欄位，一個是latitude, 另一個是longitude
# 這兩個欄位紀錄著海盜事件的位置
pirate_df <- data.frame(
    latitude = pirate_coordinate_latitude,
    longitude = pirate_coordinate_longitude
)

stopifnot(is.data.frame(pirate_df))
stopifnot(nrow(pirate_df) == 11)
stopifnot(ncol(pirate_df) == 2)
stopifnot(class(pirate_df$latitude) == "integer")
stopifnot(class(pirate_df$longitude) == "integer")
stopifnot(sum(pirate_df$latitude) == 43)
stopifnot(sum(pirate_df$longitude) == 1151)