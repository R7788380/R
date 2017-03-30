# 繪製全台各年齡層的總人口數
# 點和線條的部分可以透過 + geom_point() + geom_line() 來同時繪製
population_count <- population %>% 
    group_by(age) %>%
    summarise(count = sum(count))
ggplot(population_count, aes(x = age, y = count)) +
    geom_point() +
    geom_line()


# 1. 利用dplyr::filter 篩選出自己居住的里
# 2. 利用group_by + summarise 依據性別做加總
# 3. 利用ggplot2 繪製長條圖
filter(population, site_id =="臺南市歸仁區", village == "辜厝里") %>%
    group_by(village,sex) %>%
    summarise(count = sum(count)) %>%
    ggplot(aes(x = village, y = count)) +
    geom_bar(aes(fill = sex), stat = "identity", position = "dodge")


# 1. 利用dplyr::filter 篩選出自己居住的里
# 2. 利用ggplot2 依據人數與年齡繪製，依據年齡排序，繪製散佈圖與折線圖(geom_line)
filter(population, site_id == "臺南市歸仁區", village == "辜厝里") %>%
    group_by(age,sex) %>%
    summarise(count = sum(count)) %>%
    ggplot(aes(x = age, y = count, color = sex)) +
    geom_point() +
    geom_line()


# 請先用`substring`擷取site_id的前三個字，取得台灣的縣市級行政區名稱(取名為city)
# 然後利用filter取出自己感興趣的行政區
# 透過對city, age 做分組加總
# 再利用group_by分組對人數取平均，算出個年齡的人數比例
# 最後利用ggplot來繪圖

mutate(population, city = substring(site_id,1,3)) %>%
    filter(city == c("臺南市","臺中市")) %>%
    select(city, age, count) %>%
    group_by(city,age) %>%
    summarise(count = sum(count)) %>%
    mutate(ratio = count/sum(count)) %>%
    ggplot(aes(x = age, y = ratio, color = city)) +
    geom_point() +
    geom_line() +
    theme(text = element_text(family = "楷體-繁 黑體"))

theme_set(theme_gray(base_family = "STKaiti")) 
#中文顯示問題還有這種解決方法

