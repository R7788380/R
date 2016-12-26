library(xml2)
library(xmlview)
Url <- "https://tw.stock.yahoo.com/d/s/major_2451.html"
x <- read_html(Url)
x_tabl <- html_table(x, fill = TRUE, header = TRUE)
x_tabl <- x_tabl[10][[1]]
colnames(x_tabl) <- c("券商","買進","賣出","買超賣超","券商","買進","賣出","買超賣超")
x_tabl <- rbind(x_tabl[,1:4],x_tabl[,5:8])
x_tabl_value <- cbind(日期 = c("2016-12-25"), 股票代號 = c("2451"),
                  股票名稱 = c("創見"), x_tabl)

write.csv(x_tabl_value,"~/Desktop/爬蟲/創見2451.csv")
