# chap01_Basic

# 1. R 패키지수와 Session보기
# 2. 변수와 데이터 유형 
# 3. 패키지 사용법 
# 4. 기본 함수 사용법
# 5. 작업공간 

# 1. R 패키지수와 Session보기
dim(available.packages())
# [1] 8155   17
# 8155 - 7454
8155 - 7454 # 701

# Session 
sessionInfo() # 사용 패키지, 다국어, 버전  

# 자동완성 단축키 : Ctrl + Spase bar
# R 실행 방법 : 2가지
# 1. interaction : 줄 단위 실행
#   - Ctrl + Enter, Ctrl + R
rnorm(20) # 20개 난수 발생
hist(rnorm(20))
# 2. batch : 여러 줄 단위 실행 
pdf("c:/Rwork/output/hist.pdf")
hist(rnorm(20))
dev.off()


# 2. 변수와 데이터 유형
# 1) 변수 : 메모리 이름, 기억장소

# 2) 변수 작성 규칙 
# - 첫자는 영문자
# - 두번째는 숫자, 특수문자(_, .)
# - 대문소자 구분(Test != test)
# - 가장 최근값으로 수정
# - R의 모든 변수는 객체(data, 차트, 함수)

#[실습]
var1 <- 1 # var1 = 1(if var1 == 1)
var1
var2 <- 2
var3 <- 3

var2; var3

member.id <- 'hong'
member.pwd <- '1234'
member.addr <- '서울시 강남구'
member.id; member.pwd; member.addr

# 3) scalar, vector 변수

# scalar변수 : 1개 data 저장 
age <- 35
name <-'홍길동'
age; name

# vector변수 : 1개 이상 data 저장 
age2 <- c(35, 45, 55)
name2 <- c('홍길동', '이순신', '강감찬')
age2; name2
age2[1]; name2[3]

# 현재 메모리 상태 보기 
ls()


# 4) 자료형(data type)
# - 정수형, 실수형, 문자형, 논리형
# - type 선언 없음 - int num = 10
num <- 10
string <- '이순신'
boolean <- TRUE # FALSE
# type 확인 
mode(num) #  "numeric"
mode(string) # [1] "character"
mode(boolean) # [1] "logical"

is.numeric(num) # TRUE
is.logical(string) # FALSE

# mode() : data type
# class() : 자료구조(object type)
mode(num) # "numeric"
class(num) # "numeric"

no <- c(1:5)
name <-c('a','b','c','d','e')
no; name
emp <- data.frame(NO=no, NAME=name)
emp

mode(emp) # "list"
class(emp) # "data.frame"

# NA : 결측치 상수 
sum(10,20,30) # 60
sum(5,4,3,2,NA) # NA
sum(5,4,3,2,NA, na.rm = T) # 14

# 5) 자료형 변환 - P.23
x <- c('1','2','3')
result <- x * 3 # error 
xx <- as.numeric(x) # 문자 -> 숫자 
result2 <- xx * 3
result2 #  3 6 9

# 6) factor형 : 동일한 값을 범주로 갖는 vector
gender <- c('m','w','m','m','w')
gender # "m" "w" "m" "m" "w"
plot(gender) # error

fgender <- as.factor(gender)
plot(fgender)
fgender
str(fgender)
# Factor w/ 2 levels "m","w": 1 2 1 1 2

# factor에 vector값 지정
Ogender <- factor(gender, 
                  levels=c('w', 'm'),
                  labels=c('woman', 'man'))
Ogender

plot(Ogender)

# 3. 패키지 사용법 
install.packages('stringr')
library(stringr) # 패키지를 메모리에 올림  
search()

# stringr -> "34" "35"
str_extract_all('홍길동34이순신35','[0-9]{2}')
str_extract_all('홍길동34이순신35','[가-히]{3,}')
# "홍길동" "이순신"

# - 기본 data 셋 사용법 
# - data set 
data()
data(Nile)
Nile
Nile[1:10]
str(Nile) # Time-Series [1:100]
hist(Nile)

# 4. 기본 함수 사용법
?sum # 도움말 
# sum(..., na.rm = FALSE)
help(mean) # mean(x, ...)
mean(10,20,30) # 10
x <- c(10,20,30)
mean(x) # 20

# 5. 작업공간 
getwd() # "C:/Rwork"
setwd('c:/Rwork/Part-I')
getwd() # "c:/Rwork/Part-I"
data <- read.csv('test.csv', header=T)





