# chap01_basic

# 1. R 패키지수와 Session 보기
# 2. 변수와 데이터 유형
# 3. 패키지 사용법
# 4. 기본 함수사용법
# 5. 작업공간








# 1. R 패키지수와 Session 보기
dim(available.packages())

# Session
sessionInfo()  # 사용패키지, 다국어, 버전


# 팁
# 자동완정 단축기 : Ctrl + Space
# R 실행방법 : 2가지 
#   1) Interaction : 줄단위 실행 
#       ==> Ctrl + Enter, Ctrl + R
#      하단예제 참조
rnorm(20) # 20개 난수 발생 
hist(rnorm(20))

#   2) Batch : 여러 줄 실행 
#       ==> 
pdf("c:/Rwork/output/hist.pdf")
hist(rnorm(20))
dev.off()


# 2. 변수와 데이터 유형
# 1) 변수 : 메모리 이름, 기억장소
# 2) 변수 작성 규칙
#   - 첫자는 영문자
#   - 두번째는 숫자, 특수문자(_, .) 가능
#   - 대소문자 구분 (Test != test)
#   - 가장 최근값으로 수정
#   - R의 모든 변수는 객체 (data, chart, 함수 저장도 가능)
# [ 실습 및 샘플 ]

var1 <- 1 # var1 = 1 도 가능
var1
var2 <- 2
var3 <- 3
var2; var3

# '변수.멤버' 형태로 변수 지정 : 일반적으로 많이 함
member.id <- '홍길동'
member.pwd <- '1234'
member.addr <- '서울시 영등포구'

# scalar, vector 변수 지정

# scalar변수 : 1개 data가 저장된 변수
age <- 35
name <- '홍길동'
age; name

# Vector변수 : 1개 이상의 Data가 저장된 변수
age2 <- c(35,23,55)
name2 <- c('홍길동','이순신','강감찬')
age2;name2
age2[1]
name2[3]
var111 <- 1
name2[var111]


# 현재 메모리 상태 보기
ls()


# 4) 자료형 (data type)
# 정수형, 실수형, 문자형, 논리형
# type 선언 없음 ie. C언어의 int, double 같은것이 없음
num <- 10
string <- '이순신'
boolean <- TRUE # FALSE  논리는 대문자만 가능
mode(num)
mode(string)
mode(boolean)
is.numeric(num)
is.character(num)
is.double(string)

# mode() : data type
# class() : 자료구조 확인 함수 (object type)

mode(num)
class(num)
class(name2)

no <- c(1:5)
name <- c('a1','a2','a3','a4','a5')
no; name
emp <- data.frame(NO=no,NAME=name)
emp


mode(emp)
class(emp)


# NA : 결측치 는 상수
sum(10,20,30)    # 60
sum(5,4,3,2,NA)  # NA
sum(5,4,3,2,NA, na.rm = T)


# 5) 데이타 형변환  - 교재 22 Page
x <- c('1','2','3')
result <- x * 3  # error
xx <- as.numeric(x) # 문자 -> 숫자 형변환
result <- xx * 3
result


# 6) factor형 : 동일한 값을 범주로 갖는 Vector(하나의 변수에 1개 이상의 값을 가진변수, Array같은거)
gender <- c('m','f','m','m','f')
gender
plot(gender) # error
fgender <- as.factor(gender)
fgender
plot(fgender)
str(fgender)    # Factor w/ 2 levels "f","m": 2 1 2 2 1
class(fgender)  # [1] "factor"
mode(fgender)   # [1] "numeric"

# factor에 vector값 지정
Ogender <- factor(gender, levels=c('f','m'), labels=c('woman','man'))
Ogender
plot(Ogender)


# 3. 패키지 사용법
# 패키지 설치 --> 메모리에 올림 --> 정상인지 확인 순서로 일함
install.packages('stringr')
library(stringr) # 패키지를 메모리에 올리는 명
search()

str_extract_all('홍길동34이순신35','[0-9]{2}') # [1] "34" "35"
str_extract_all('홍길동34이순신35','[가-히]{3}') # [1] "홍길동" "이순신"


# - 기본제공 데이타 Set 사용법
# - 기본제공되는 data set
data(EuStockMarkets)
EuStockMarkets
EuStockMarkets[1:20]
str(EuStockMarkets)
hist(EuStockMarkets)



# 4. 기본 함수 사용법
?sum   # sum(..., na.rm = FALSE)
help(mean)  # mean(x, trim = 0, na.rm = FALSE, ...)
mean(10,20,30)    # 10, mean은 하나의 변수에 대해 평균을 구함 즉 벡터값을 넣어야함
x <- c(10,20,30)
mean(x)  # 20


# 5. 작업공간
getwd() # [1] "C:/Rwork"
setwd('C:/Rwork/Part-I')
getwd() # [1] [1] "C:/Rwork/Part-I"
setwd('C:/Rwork')
filedata <- read.csv('c:/Rwork/Part-I/test.csv', header=T) # 기본폴더에서 가져올때는 그냥 파일명만 명시해도 된다. 
filedata











