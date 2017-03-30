#使用ls() or objects()列出目前所有存在的object名稱
#rm() 刪除object
#min() 最小值
#max() 最大值
#range() 求最小值到最大值範圍 == c(min(x),max(x))
#sum() 求加總
#length() 傳回目標長度
#mean() 求平均
#var()  Rstudio使用的是樣本變異數(n-1)，不是母體變異數(N)
#sd()   同理，Rstudio使用樣本標準差(n-1)
#sort() 由小至大升冪排列
#sqrt() 開根號   sqrt(-1+0i)為一複數，R會自動調整，而不會傳回NaN
#seq(1,10,by=4) [1] 1 5 9
#seq(1,5,length.out = 3)  [1] 1 3 5
#seq(1,by = 2,length.out = 3) [1] 1 3 5
#rep(1:3,each = 3,times = 2) [1] 1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3
#T==TRUE  F==FLASE  NA遺失值  NaN無定義值  Inf==無限大  注意大小寫
#>  <   >=   <=   ==等於   !=不等於    &且  |或
#is.na() 檢查是否有遺失值
#若輸入的字符串中有雙引號’”‘，則在雙引號之前插入'\'，例如："愛\""
#paste(c("a","b"),1:4,sep = "") [1] "a1" "b2" "a3" "b4"  
