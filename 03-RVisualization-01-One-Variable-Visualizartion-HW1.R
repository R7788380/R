if (TRUE) {
    # 以下指令可以畫出lty的數字與畫圖後的結果
    showLty <- function(ltys, xoff = 0, ...) {
        stopifnot((n <- length(ltys)) >= 1)
        op <- par(mar = rep(.5,4)); on.exit(par(op))
        plot(0:1, 0:1, type = "n", axes = FALSE, ann = FALSE)
        y <- (n:1)/(n+1)
        clty <- as.character(ltys)
        mytext <- function(x, y, txt)
            text(x, y, txt, adj = c(0,-0.3), cex = 0.8, ...)
        abline(h = y, lty = ltys, ...); mytext(xoff, y, clty)
        y <- y - 1/(3*(n+1))
        abline(h = y, lty = ltys, lwd = 2, ...)
        mytext(1/8+xoff, y, paste(clty," lwd = 2"))
    }
    showLty(1:6)
}

#<http://newtomaso.blogspot.tw/2015/02/par-in-r-rpar.html>
#mar = c(bottom, left, top, right) 設定四周空白邊界行數
#type種類 "p"：點、"l"：線、"b"：點線連接(點覆蓋在線上)
#         "o"：點線連接(點穿過線)、"h"：點垂直連到x軸上
#         "s"：階梯形狀
#<http://blog.qiubio.com:8080/archives/2395>

