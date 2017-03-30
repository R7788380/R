y = list(a = c(1,2,3), b = TRUE, c = "87") #列表$，可容納不同型態元素
mode(c(y[1],y[2],y[3])) #第一層[]都是list，看輸出x[1]就知道
mode(y[[1]]) #第二層[[]]才是針對裡面元素型態
y[[3]]==y[["c"]] #有時候資料太過龐大不知道元素在第幾個，直接輸入也行
y[[3]]==y$c
y$'a' #windows中有時使用$來選取元素可能會出錯，建議使用跳脫字元''
matrix("87",2,2);array(TRUE,2,2) #矩陣陣列裡面的元素必須同態
c <- data.frame(a = "87", b = 1:3, c = TRUE) 
#數據匡就像Excel的格式一樣，可容納不同型態的元素
#因為數據匡是結構化(表格)，所以不能放太過不同型態的物件
#只能numeric, character, logical, factor, nimeric matrix, list, data.frame
#有時要建立龐大的數據匡資料，使用Excel反而比較方便
#因為數據匡是二維表格，就像對稱矩陣一樣，每行的長度必須相同
#如果長度不一致，R會自動補齊，輸出c就能了解
data.frame("87", 1:3, TRUE) #沒有設定變數名稱也可以
mode(c) #數據匡就是由list組成，只是list輸出格式較龐大而不易觀察
c$a #數據匡一樣可使用list的選取方式，這裡只列出一個
nrow(c);  ncol(c); dim(c); c[,1] #也可使用matrix語法找出行數列數維度位置
dimnames(c) #找出各欄名稱
class(c$a) #注意數據匡會將裡面的元素自動轉換成factor
c[1:2, "b", drop = FALSE] 
#直接輸出x[1:2,"b"]會被R破壞成向量，可以令drop = FALSE來維持數據匡結構
z <- lm(y ~ x1+x2+x3,data) #迴歸分析函數lm()，y為被解釋變數，abc為解釋變數
#y = a + b1*x1 + b2*x2 + b3*x3 + c a為Intercept   b1,b2,b3為coefficient  c為residual value
#顯示出相關係數的截距,各項參數估計值
summary(z) #使用summary()可以顯示回歸統計量
#擬和值,殘差值,R-squared,p-value等等...


#回歸
X <- model.matrix(~ Type + Treatment + conc, CO2)
#建立一個基於Type、Treatment和conc的矩陣
y <- CO2$uptake
beta.hat <-  solve(t(X) %*% X) %*% t(X) %*% y 
#找出beta.hat讓X %*% beta.hat很接近y
all.equal(solve(t(X) %*% X) %*% t(X) %*% y, 
          solve(t(X)%*%X,t(X)%*%y))  #第二參數b裡外都可放
z <- cor(X %*% beta.hat,y)  #算出估計出的y和真值y的相關係數
z^2#相關係數z的平方就是R-squared (SSE)
#R-squared能夠判斷出一個模型是否完善

#上述的結果就如同直接跑'lm'回歸
g <- lm(uptake ~ Type + Treatment + conc, CO2)
g.s <- summary(g) #summary看所有統計量
g.s$r.squared #此值就是z^2 
