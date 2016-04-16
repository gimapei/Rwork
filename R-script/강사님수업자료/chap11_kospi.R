###################################################
####    국내 종합주가지수 kospi 데이터 시각화  ####
###################################################

# 주식데이터 다운로드 
# http://www.google.com/finance

sam_kospi <- read.csv(file.choose(), header=T,encoding='UTF-8')
nrow(sam_kospi) # 245
head(sam_kospi)

# 칼럼명 수정 
names(sam_kospi) <-c('Date','Open','High','Low','Close','Volume')

# 150 레코드 추출
sam_kospi150 <- head(sam_kospi, 150)
sam_kospi150

# Date 정보 수정 - 15-04-2016 -> 2016-04-15
Sys.setlocale(locale = 'English_USA')
sdate <- as.character(sam_kospi150$Date)
sdate # 7-Sep-15
Rdate <- strptime(sdate, "%d-%b-%y")
head(Rdate)
class(Rdate) # "POSIXlt" "POSIXt" 
sam_kospi150$Date <- Rdate
head(sam_kospi150)

# xyplot(y ~ x, data = data)
xyplot(High + Low ~ Date, type = 'l', data=sam_kospi150) 
X11()

xyplot(High + Low ~ Date, type = 'l', 
       col = c('red','blue'), 
       data=sam_kospi150)


