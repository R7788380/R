library(xml2)
library(xmlview)
library(stringr)
new_url <- "http://www.appledaily.com.tw/realtimenews/section/new/"
title_news <- read_html(new_url) 
xml_view(title_news, add_filter = TRUE)
title_news_node <- xml2::xml_find_all(title_news, 
                                      '//ul[@class="rtddd slvl"]', 
                                      ns=xml2::xml_ns(title_news))

title_news_content <- title_news_node %>% xml_text() %>% strsplit(split = "\n")
title_news_content <- str_trim(title_news_content[[1]], side = "both")
title_times_seq <- seq(3,206,7)
title_times <- title_news_content[title_times_seq]
title_species_seq <- seq(4,207,7)
title_species <- title_news_content[title_species_seq]
title_content_seq <- seq(5,208,7)
title_content <- title_news_content[title_content_seq]

today_news <- data.frame(日期 = c("2016.12.26"),
                         時間 = title_times,
                         種類 = title_species,
                         狂新聞 = title_content)

write.csv(today_news,"~/Desktop/爬蟲/蘋果每日報.csv")
#要跳頁面直接改網址尾數即可
#"http://www.appledaily.com.tw/realtimenews/section/new/2"
#"http://www.appledaily.com.tw/realtimenews/section/new/3"，以此類推
