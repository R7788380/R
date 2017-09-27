# object 物件 
# mode()向量型態 "logical" "integer" "numeric" "complex" "character" "raw"
#logical==邏輯 integer==整數    numeric==數值 
#complex==複數 character==字串  raw==位元
# class()類 "numeric" "logical" "character" "list" "matrix" "array" 
#          "factor"  "data.frame"
#list() 向量列表  標記：$ , [[1]] , [[2]]....
#lm(a ~ b, data = )迴歸 a：被解釋變數  b：解釋變數
#使用[]抽出的物件型態，與本身物件形態相同，例如:mode(a[1]) 型態與a相同
#attributes() 屬性，會以列表$形式輸出類class 名稱names
#attr(x,"names") 抽出名稱是names的屬性，輸出為字符串，結果與names(x)相同