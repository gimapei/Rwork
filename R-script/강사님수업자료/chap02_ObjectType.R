# chap02_ObjectType

###########################
# 1. Vector 자료구조
###########################

# 벡터 데이터 생성 함수
v1 <- c(1:20) # combine value
v1
v2 <- seq(1, 10, 2) # sequence value
v2
v3 <- rep(1:3, 3) #replicate value
v3
v3 <- rep(1:3, each=3)
v3 # 1 1 1 2 2 2 3 3 3

# 벡터 데이터 처리 함수
x <- c(1,3,5) 
y <- c(3,5)
union(x, y) # 합집합 
setdiff(x, y) # 차집합: x - y
intersect(x, y) # 교집합 : 3 5      

# 벡터 변수에 저장
v1 <- c(33,-5,20:23,12,-2:3)
v2 <-c("홍길동", "이순신", "유관순") # '홍길동'
v3 <-c(T, TRUE, FALSE, T, TRUE,F,T)
v1;v2;v3
# 동일한 타입으로 1차원 배열 생성 
v4 <- c(33,-5,20:23,12,"4")
v4
result <- v4 + 10 # error
result2 <- as.numeric(v4) + 10
result2

# 같은 줄에 명령문 중복사용
v1; mode(v1) 
v2; mode(v2)
v3; mode(v3)

# 벡터에 컬럼명 지정
age <- c(10,20,30)
age
names(age) <- c("홍길동", "이순신", "강감찬")
age
age <-NULL # age 변수 데이터 삭제

# 특정 요소 출력 및 제외
# 변수[index] # index = 1
a <- c(1:50)
a[1]
a[10 : 45] # 10~45
l <- length(a)
l
a[10 : (l-5)] # 10~45
a[1, 2] # error  -> a[row, column]   

# --------------------------------------------------------
# <연습문제1>
# --------------------------------------------------------


#########################################
# 2. Matrix : 동일 데이터 타입을 갖는 2차원 배열
#########################################

# - 관련함수 : rbind():행묶음, cbind():컬럼 묶음, apply() : 함수적용

# (1) c()함수 이용 matrix 생성
m <- matrix(c(1:5))     
m
m <- matrix(c(1:9), nrow=3) # error
m
m <- matrix(c(1:10), nrow=2, byrow=T) 
m
# (2) rbind()/cbind() 함수 이용      
x1 <- c(5,40,50:52) 
x2 <- c(30,5,6:8) 
x1; x2
mr <- rbind(x1,x2) 
mr
mc <- cbind(x1,x2)  
mc
# (3) matrix()함수 이용
m3 <- matrix(10 : 19, 2) #10개 데이터를 2행으로 생성
m3
nrow(m3) # 2
ncol(m3) # 5

# 자료와 객체 Type 보기
mode(m3); class(m3) #numeric, matrix

# ma행렬 데이터 접근 : [첨자,첨자] 이용
# 변수[행, 열] -> 변수[2,5]
m3[1,] # 1행 전체
m3[,5] # 5열 전체
m3[2,3] #2행 3열의 데이터 1개 -> 15
m3[1, 2:5] # 1행에서 2~5열 데이터 4개

# matrix 데이터 처리 함수      
x <- matrix(c(1:9), nrow=3, ncol=3) # 3행 3열 matrix 객체
length(x) # 데이터 개수 
ncol(x); nrow(x) # 열/행 수
x
# matrix에 컬럼이름 적용하기
colnames(x) <- c("one", "two", "three")   
x

# 형식) apply(matrix변수, 행(1)/열(2), 함수)
max(2,1,5) # 5

apply(x,1,max) # 행 단위 최대값
apply(x,1,sum)
apply(x,1,min) # 행 단위 최대값
apply(x,2,mean) # 열 단위 평균값   
apply(x,2,sum)

# 사용자 함수와 apply() 적용
f <- function(x){ # x : 매개변수 
     x * c(1,2,3) # 1 4 7 -> 1 8 21
}

apply(x, 1, f)


#########################################
# 3. Array : 동일 데이터 타입을 갖는 다차원 배열
#########################################
# 변수[행,열,면]
d <- c(1:12) # 12개 벡터 객체 생성
arr <- array(d, c(3,2,2)) # 3행2열2면 -> 3차원 배열 객체 생성
arr

# 배열 조회
arr[,,1] #1면 
arr[,,2] #2면 

# 배열 자료형과 자료구조 
mode(arr); class(arr) #numeric, array

#########################################
# 4. List : 서로 다른 데이터 구조
#########################################

# 성격이 다른 데이터(벡터, 행렬, 데이터프레임 등 모든 데이터)

# 1개의 원소를 갖는 리스트
list <- list("lee","이순신",95,"hong","홍길동",85)
list
unlist <- unlist(list) # list 구조 제거 -> vector      
unlist
# 2개 이상의 원소를 갖는 리스트
num <- list(c(1:5), c(6:10))
num
# key=value형태로 저장      
num2 <- list(first=c(1:5), second=c(6:10))
num2
num2$first 
num2$second
# key, value 형태로 저장
member <- list(name="hong",age = 35,
               address="한양",gender="남자")
member
member$age <- NULL
# list 원소 접근 - 변수$키
member$age # 35
member$age <- 45  
member$id <- "hong"
member$pwd <- "1234"      
member
member$age <- NULL  # 원소 제거

# list의 데이터와 객체 타입 보기
mode(list); class(list) # list, list

length(member) # 6 -> 리스트 수

# list data 처리 함수
a <- list(c(1:5))
b <- list(6:10)    

# matrix -> apply() 
lapply(c(a,b), max) # list로 결과 반환
sapply(c(a,b), max)  # vactor로 결과 반환


###################################################
# 5. Data Frame : 행과 열의 2차원 자료구조, Table구조와 동일  
###################################################

# 1) Vector이용 객체 생성
no <- c(1,2,3)
name <- c("hong", "lee", "kim")
pay <- c(150,250,300)
vemp <- data.frame(NO=no, Name=name, Pay=pay) #컬럼명 지정 
vemp
vemp$NO
pay <- vemp$Pay
# 급여의 합계와 평균을 구하시오.
sum(pay); mean(pay); var(pay) # 5833.333

# 2) matrix이용 객체 생성
m <- matrix(
  c(1,"hong",150,
    2, "lee", 250,
    3, "kim", 300) ,3 ,by=T) # 행우선, 3개 리스트 생성
memp <- data.frame(m)      


# 3) txt파일 이용 객체 생성
getwd()
setwd("C:/Rwork/Part-I") 
txtemp <- read.table('emp.txt', header=T, sep="") # 제목있음, 공백구분
txtemp
class(txtemp) # "data.frame"

# 4) csv파일 이용 객체 생성
csvtemp <- read.csv('emp.csv', header=T) # 제목있음, 컴마구분
csvtemp
class(csvtemp) # "data.frame"
# 최대급여를 받는 사람은? if문 
pay <- csvtemp$급여
max(pay) # 500


# 컬럼명이 없는 파일인 경우
name <- c("사번","이름","급여")
read.csv('emp2.csv', header=F, col.names=name)    


# <실습1> 데이터프레임 만들기      
df <- data.frame( x=c(1:5), y=seq(2,10,2), 
                  z=c('a','b','c','d','e') )

# <실습2> student 데이터프레임 만들기  

# --------------------------------------------------------
# <연습문제2>
# --------------------------------------------------------     


# 5) apply() 함수 적용 : 데이터프레임 객체에 apply() 적용
# apply(변수, 행/열, func)
# 변수 : matrix, data.frame

r1 <- c(100,80,90)
r2 <- c(90,80,75)
r3 <- c(86,78,95)    
Data <-data.frame(r1=r1, r2=r2, r3=r3)
Data
# 형식) apply(data.frame, 1/2, 함수)
apply(Data, 1, min) # 열 단위 함수 적용 - 86 78 75
apply(Data, 2, min) # 행 단위 함수 적용 - 80 75 78 
# 행 단위로 최대값, 평균을 구하시오.
apply(Data, 1, max)
apply(Data, 1, mean)
# 열 단위로 합계와 분산, 표준편차을 구하시오.
apply(Data, 2, sum)
apply(Data, 2, var) # 72.33333 
apply(Data, 2, sd) # 8.504901
round(apply(Data, 2, var), 2) # 소숫점 2자리 

# --------------------------------------------------------
# <연습문제3>
# --------------------------------------------------------                 

##############################################
# 6) 서브셋 만들기    
##############################################
# 변수 <- subset(data.frame, 조건)
x <- c(1:6)
y <- c(7:12)
df <- data.frame(x=x, y=y)
df

x1 <- subset(df, x>=3) # x가 3이상인 레코드 대상       
x1
y1 <- subset(df, y<=8) # y가 8이하인 레코드 대상 
y1
xy <- subset(df, x>=2 & y<=10) # 2개 조건이 참인 레코드 대상
xy # 0
# & : and, | : or
xy <- subset(df, x>=2 | y<=10)
xy

##############################################
# 7) Data join : 칼럼 값으로 기준으로  두 개의 프레임 연결    
##############################################

height <- data.frame(id=c(1,2), h=c(180,175))
weight <- data.frame(id=c(1,2), w=c(80,75))

user <- merge(height, weight, by.x="id", by.y="id")
user
# --------------------------------------------------------
# <연습문제4>
# -------------------------------------------------------- 


##############################################
# 8) 문자열 처리 함수와 정규표현식
##############################################
# stringr 패키지에서 제공하는 함수 이용 문자열 처리

install.packages("stringr")  # 패키지 설치
library(stringr) # 메모리 로딩

string <- "abcd12aaa33"

str_extract(string, "[0-9]{2}") # "12" -> 연속된 숫자2개 추출(첫번째)
# "12"
str_extract_all("abcd12aaa33", "[1-9]{2}") # "12" "33" -> 모두
# "12" "33"
id <- '123456-2234567'
str_extract(id, '[0-9]{6}-[1234][0-9]{6}')
str_extract(id, '\\d{6}-[1234]\\d{6}')
# [1] "123456-1234567"
# [1] NA

mail <- 'kpjiju@naver.com'
str_extract(mail, '\\w{4,}@\\w{3,}.\\w{2,}')
# [1] "kpjiju@naver.com"

d <- c("김길동","유관순","강감찬","김길동")      
str_replace(d, "김길동","홍길동") # 문자열 교체
subs <- str_sub("abcd12aaa33", 3,6) # 서브스트링      
subs
# --------------------------------------------------------
# <연습문제5>
# -------------------------------------------------------- 


#<연습문제4> kor(국어 점수 2개)과 eng(영어 점수 2개)를 id로 merge해서 
# score에 할당하시오.
# <score 결과>
#  id kor eng
#1  1  85  95
#2  2  75  86     
kor <- data.frame(id=c(1:2), kor=c(85,75))
eng <- data.frame(id=c(1:2), eng=c(95,86))
score <- merge(kor, eng, by.x="id", by.y="id")
score

# <연습문제5> 다음의 Data2 객체를 대상으로 정규표현식을 적용하여 문자열을 처리하시오
Data2 <- c("2015-02-05 income1coin","2015-02-06 income2coin","2015-02-07 income3coin")

#<조건1> 일짜별 수입(코인 수)을 출력하시오. 
#        출력 결과) 1coin 2coin 3coin 
result <- str_extract_all(Data2, '[0-9][a-z]{4}')
unlist(result) # [1] "1coin" "2coin" "3coin"

#<조건2> 위 벡터에서 연속하여 2개 이상 나오는 모든 숫자를 제거하시오.  
#        출력 결과) "-- income1coin" "-- income2coin" "-- income3coin"  

#<조건3> 위 벡터에서 -를 /로 치환하시오.

#<조건4> 모든 원소를 쉼표(,)에 의해서 하나의 문자열로 합치시오. 
# 힌트) paste(데이터셋, collapse="구분자")함수 이용



