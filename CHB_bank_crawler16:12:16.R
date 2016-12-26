library(xml2)
library(xmlview)
CHB_bank <- read_html("http://wcag.chb.com.tw/G0100.jsp")
xml_view(CHB_bank,add_filter = TRUE)
td1 <- xml_find_all(ESun_bank, '//tr/td', ns=xml_ns(ESun_bank))
td1 <- xml_text(td1)
td1_name_seq <- seq(9,63,3)
td1_name <- td1[td1_seq]
td1_in_seq <- seq(10,64,3)
td1_in_price <- td1[td1_in_seq]
td1_out_seq <- seq(11,65,3)
td1_out_price <- td1[td1_out_seq]

CHB_price <- data.frame(幣別名稱 = td1_name, 
                        買入價格 = td1_in_price,
                        賣出價格 = td1_out_price)
write.csv(CHB_price,"~/Desktop/銀行爬蟲/CHB_bank.csv")
