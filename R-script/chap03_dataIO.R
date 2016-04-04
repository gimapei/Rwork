# chap03_dataIO

###################################
# 1. 데이터 불러오기
###################################

# 1-1. 키보드 입력

# 1) scan() 함수를 이용
# 숫자입력 
x <- scan()
x

# 합계 구하기
sum <- sum(x) 
sum

# 문자입력
y <- scan(what="")
y

mmmmm <- scan(what="")
mmmmm

# 2) edit() 함수를 이용한 입력
df = data.frame() #빈 데이터프레임 생성
df = edit(df) # 데이터 편집기
df

# 1-2. 파일 데이터 가져오기

# 1) read.table() 함수 이용

# (1) 컬럼명이 없는 파일 불러오기
getwd()
setwd("C:/Rwork/Part-I")
student  <- read.table(file="student.txt")
student


# (2) 컬럼명이 있는 파일 불러오기
student1  <- read.table(file="student1.txt", header=TRUE)
student1

# (3) 구분자가 있는 경우(세미콜론, 탭)
student2  <- read.table(file="student2.txt", sep=";", header=TRUE) # 세미콜론
student2


# (4) 특정문자 NA 처리(- 문자열을 NA로 처리)
student3<-read.table(file="student3.txt", sep=" ", header=TRUE, na.strings=c('-','*','/'))
student3


# 문제 : 키와 몸무계의 평균을 구하시오
hh <- student3$키
mean(hh, na.rm=T)

ww <- student3$몸무게
mean(ww, na.rm=T)


# 2)  read.csv() 함수 이용

student4 <- read.csv(file="student4.txt", na.strings="-")

student4 <- read.csv(file.choose(), sep=",", na.strings="-")   # 파일열기 


# 3) read.xlsx() 함수 이용 - 엑셀데이터 읽어오기
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_77')

# rJava를 로드하기 때문에 rJava 패키지 설치 필요
install.packages("rJava")
library(rJava) # 로딩

# xlsx 패키지 설치
install.packages("xlsx")
library(xlsx) # 로딩

# studentex.xlsx 파일 선택
studentex <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8")
studentex

# 4) 인터넷에 있는 파일 가져오기
# http://data.worldbank.org
# 국제은행의 데이타를 통해 우리나라 GDP 순위를 알아보자.
# #1. 데이타 가져오기
GDP_ranking <- read.csv('http://databank.worldbank.org/data/download/GDP.csv')
GDP_ranking
# #2. 데이타 분포 확인
head(GDP_ranking)
tail(GDP_ranking)

# #3. 데이타 전처리
GDP_ranking20 <- head(GDP_ranking,20)
GDP_ranking20

# #4. 불필요한 데이타 제거  -c는 제거하겠다는의미 (from, to) 행, 열 순
GDP_ranking20 <- GDP_ranking[-c(1:4),c(1,2,4,5)]
GDP_ranking20

# #5. 컬럼수정
names(GDP_ranking20) <- c('CODE','RANK','NATION','GDP')
GDP_ranking20

GDP_ranking20 <- head(GDP_ranking20,20)


# #6. GDP 컬럼 선처리 ( 문자 --> 숫자 )
Nation <- GDP_ranking20$NATION
GDP1 <- GDP_ranking20$GDP
GDP1 

# #7. 콤마 제거
GDP1 <- str_replace_all(GDP1,",","")
GDP1
GDP1 <- str_trim(GDP1)
GDP1

# #8. 숫자로 변경
GDP1 <- as.numeric(GDP1)
GDP1

# #9. 차트그리기
barplot(GDP1, main= '세계 GDP 순위', col=rainbow(15), xlab='국가')

# #10. y축 이름 수정
GDP1 <- GDP1 / 1000
GDP1

barplot(GDP1, main= '세계 GDP 순위', col=rainbow(15), xlab='국가', ylab='단위:달러', ylim=c(0, 20000))

# 5) 웹문서 가져오기
install.packages("XML")
library(XML) # <table> <tr> <td> 등의 테그를 인식하는 라이브러리 

# 미국의 각 주별 1인당 소득자료
info.url <- "http://www.infoplease.com/ipa/A0104652.html"

# readHTMLTable() 함수 역할 - <table>,<tr>,<td> 태그 이용
info.df<-readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
# header=T : 컬럼명 있음, which=1 : 첫번째, stringsAsFactors 문자는 범주(값의 목록)처리 안함
info.df

# 레코드 수 변경 확인 <- update
info.df<-info.df[1:53,] # NA 레코드 제거(54행 제거)
info.df


info.df<-info.df[c(-2,-28),] # $가 있는 행 제거
info.df

# 컬럼명 변경
info.df<-info.df[c(-1,-2),] # 1,2행 제거
info.df

# 컬럼명 추가
names(info.df) <- c("State",1980,1990,1995,2000,2003,2006,2009,2012)
head(info.df) 


# 문제, 주별 전체 합계를 구하시오
info.df.2012 <- info.df$`2012`
info.df.2012
info.df.2012 <- str_replace_all(info.df.2012,',','')
info.df.2012
info.df.2012 <- as.numeric(info.df.2012)
info.df.2012

info.df.2009 <- info.df$`2009`
info.df.2009
info.df.2009 <- str_replace_all(info.df.2009,',','')
info.df.2009
info.df.2009 <- as.numeric(info.df.2009)
info.df.2009

info.df.state <- info.df$'State'
info.df.state


df <- data.frame(y2009=info.df.2009, y2012=info.df.2012)

sum <- apply(df, 1, sum)
sum

df2 <- data.frame(STATE=info.df.state, df)
df2


barplot(sum, names.arg=unlist(info.df.state), main='주별합계(2009+2012)', col=rainbow(15), xlab='주', ylab='단위:달러')



###############################
# 2. 데이터 저장하기
###############################

# 2-1. 화면(콘솔) 출력

# 1) cat() 함수
x <- 10
y <- 20
z <- x * y
cat("x*y의 결과는 ", z ," 입니다.\n")  # \n 줄바꿈
cat("x*y = ", z)

# 2) print() 함수
print(z*200) # 변수 또는 수식만 가능


# 2-2. 파일에 데이터 저장

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_77')

# 1) sink() 함수를 이용 파일 저장
setwd("C:/Rwork/output") 
sink("savework.txt") # 저장할 파일명



# studentexcel.xlsx 파일 선택
studentx <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8") 
studentx #출력되는 값이 화면에 나타나지 않고 파일에 저장됨
sink() # 해제


# 2) write.table()함수 이용 파일 저장
getwd() # C:/Rwork/output 경로 확인 

#(1) 기본옵션으로 저장 - 행 이름과 따옴표 붙음
write.table(studentx, "stdt.txt") 
#(2) 행 이름 제거하여 저장
write.table(studentx, "stdt2.txt", row.names=FALSE) 
#(3) 따옴표 제거하여 저장
write.table(studentx, "stdt3.txt", row.names=FALSE, quote=FALSE) 


# 3) write.xlsx() 함수 이용 파일 저장 - 엑셀 파일로 저장
library(xlsx) # excel data 입출력 함수 제공

# studentexcel.xlsx 파일 선택
st.df <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8")
str(st.df)
write.xlsx(st.df, "studentx.xlsx") # excel형식으로 저장

#4) write.csv() 함수 이용 파일 저장
# data.frame 형식의 데이터를 csv 형식으로 저장
setwd("C:/Rwork/output")
st.df
write.csv(st.df,"stdf.csv", row.names=F, quote=F) # 행 이름 제거

# --------------------------------------------------------
# <데이터 입출력 연습문제>
# --------------------------------------------------------     

# chap03_DataIO (연습문제)


# <연습문제> info.df 데이터 프레임을 infoprocess.csv 파일로 
#            저장한 후 데이터프레임으로 가져오시오.


#### 사전준비 내용

library(XML) # <table> <tr> <td> 등의 테그를 인식하는 라이브러리 
info.url <- "http://www.infoplease.com/ipa/A0104652.html"
info.df<-readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
names(info.df) <- c("State",1980,1990,1995,2000,2003,2006,2009,2012)
head(info.df) 


# <조건1> "C:/Rwork/output" 디렉토리에 "infoprocess.csv"로 저장
# 힌트) write.csv()함수 이용
setwd("C:/Rwork/output")
write.csv(info.df,"infoprocess.csv") # 행 이름 제거


# <조건2> "infoprocess.csv" 파일을 infoData 데이터 프레임으로 가져와서 결과 확인
infoData <- read.csv('infoprocess.csv')
infoData

# <조건3>  infoData 데이트 셋 구조 보기 함수를 이용하여 관측치와 컬럼수 확인
head(infoData[-c(3,4)],6)
head(infoData)
tail(infoData)
class(infoData)

# <조건4> 1980년과 1990년을 제외한 나머지 컬럼 대상으로 상위 6개 관측치 보기
head(infoData[-c(3,4)],6)




