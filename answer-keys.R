# We only need two packages here
library(data.table)
library(stringr)
# set `data_path` to your dir
data_path <- "D:/learn/Rstatistics/r-data-practice"
setwd(data_path)
# read into data
data <- readRDS("data/stock-market-data.rds")
data[1:5] # show top 5 obs
#---1. 哪些股票的代码中包含"8"这个数字？----
# 首先，我们需要把股票代码symbol中包含8的那些观测找出来。我们可以借助stringr这个
# 字符串处理包。这一步不难，稍微有些挑战的是去重。如果我们不去重，那么我们会得到
# 非常多的重复观测。例如股票600128，如果它一共有100天的观测，那么我们会出现100个
# 重复结果。为了去重，我们需要借助于data.table中的unique函数。代码如下。
data[str_detect(symbol,'8'),unique(symbol)]

#---2. 每天上涨和下跌的股票各有多少？----
data[,
     .(num = uniqueN(symbol)),
     keyby = .(date, updown = ifelse(close - pre_close > 0, "UP", "DOWN"))
     ][1:10]
