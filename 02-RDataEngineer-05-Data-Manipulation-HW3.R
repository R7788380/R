#' 請同學利用之前所學，從cl_info的欄位data_dt的資料中萃取出資料的「年和月」，並存到欄位 year_month
#' 並且最後只留下 year_month 與 mortgage_bal兩個欄位
#' 這裡的data_dt 是收集資料的時間點
#' mortgage_bal 是房貸餘額
cl_info2 <- local({
    cl_info %>% select(data_dt ,mortgage_bal) %>%
        mutate(mortgage_bal, year_month = substr(cl_info$data_dt, 1, 7)) %>%
        select(year_month, mortgage_bal)
    # 請填寫你的程式碼
})

stopifnot(class(cl_info2$year_month)[1] == "character")
stopifnot(ncol(cl_info2) == 2)
stopifnot(!is.null(cl_info2$mortgage_bal))

#' 請算出每個月份的 mortgage_bal 的總和
#' 並且把結果放在 mortgage_total_bal 欄位
#' 結果請依照月份由小到大做排序
cl_info3 <- local({
    cl_info2 %>%  
        group_by(year_month) %>%
        summarise(mortgage_total_bal = sum(mortgage_bal, na.rm = TRUE))
        arrange(year_month)# 請填寫你的程式碼
})

stopifnot(nrow(cl_info3) == 98)
stopifnot(ncol(cl_info3) == 2)
stopifnot(!is.unsorted(cl_info3$year_month))
#' 這個資料集只要能和GDP做比較，就是一個我國房地產泡沫化的指標