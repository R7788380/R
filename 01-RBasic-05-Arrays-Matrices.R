#matrix() 二維矩陣
matrix(1:6,2,3,byrow=FALSE) #產生2x3矩陣，byrow=FALSE代表按col由上而下排列
#attributes:$dim，輸出list格式
#可使用dim(x) <- c()來改變x的維度，甚至更高維度
#array() 多維陣列
array(1:18,c(2,3,3)) #array可以產生高維度的矩陣
#可以使用[]搭配logical向量來取出矩陣或陣列中的值
#例如：x[c(TRUE,TRUE,FALSE),,]，代表取出x[1:2,,]的值
#R會自動重複向量來補齊維度所需的範圍，matrix(1:2,3,3)
#所有的矩陣和陣列都有$dim屬性，可以使用dim() <- NULL來移除dim屬性，會變回向量
#cbind() 使行(橫向)合併
cbind(matrix(1:4,2,2),matrix(1:4,2,2)) #會變成2x4矩陣
#rbind() 使列(縱向)合併
cbind(matrix(1:4,2,2),matrix(1:4,2,2)) #會變成4x2矩陣
#矩陣乘法Notation %*%，計算兩矩陣的內積，注意維度
matrix(1:6,2,3) %*% matrix(1:12,3,4) #會得到2x4的新矩陣
1:3 %*% 1:3 #計算向量內積
#矩陣與向量相乘時，向量會被視為行row向量
matrix(1:9,3,3) %*% 1:3 #1:3會視為matrix(1:3,3,1)，會得到3x1的新矩陣
#t() 對矩陣轉置，維度互換，但是注意排序方向
t(matrix(1:6,2,3)) #與matrix(1:6,3,2,byrow=TRUE)相同
#diag() 產生單位矩陣，主對角線預設為1
diag(1,4) #產生4x4且主對角元素為 1 的矩陣
diag(matrix(1:9,3,3)) #可以取出主對角線的元素，以向量表示
diag(diag(matrix(1:9,3,3))) #輸出改為向量，請與上式比較
#solve() 求逆矩陣與線性運算
solve(matrix(1:4,2,2)) #注意只有對稱矩陣才能計算逆矩陣，2x2 3x3 4x4
solve(A,B) #解出線性方程 A %*% x = B 的x值
#eigen() 求出特徵值values及特徵向量vectors，輸出以list表示，用$提取
#請參考 https://www.youtube.com/watch?v=OGZX9CYYEic
#       https://goo.gl/YIDNvH