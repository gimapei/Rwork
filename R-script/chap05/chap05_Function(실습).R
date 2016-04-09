# chap05_Function 수업내용
#  사용자 정의함수와 R 내장함수

# 1. 사용자 정의함수

# 매개변수가 없는 함수 예
p <- function(){
  cat("매개변수가 없는 함수")
}
p() # 함수 호출

#매개변수가 있는 함수 예
p<- function(x){
   cat("x의 값 = ",x, "\n") # \n 줄바꿈
   print(x) # 변수만 사용
}
p(5+10) # 함수 호출

#파일 불러오기
setwd("c:/Rwork/Part-I")

test <- read.csv("test.csv", header=TRUE)
head(test)

summary(test) # 요약통계량
table(test$A) # A변수 대상 빈도분석

#변수A 대상 빈도분석,최대값, 최소값 구하기 함수
fa <- function(){
  a <- table(test$A) # A변수 대상 빈도분석
  cat("변수 A에 대한 빈도분석 결과 \n")
  print(a) # 빈도분석 
  cat("max =", max(a), "\n")
  cat("min =", min(a))
}
fa() #함수 호출


#파타고라스 정의 증명- 식 : a^2+b^2=c^2
pytha <- function(s,t){
  a <- s^2 - t^2
  b <- 2*s*t
  c <- s^2 + t^2
  cat("피타고라스의 정리 : 3개의 변수 : ",a,b,c)
}

pytha(2,1) # s,t는 양의 정수 -> 3 4 5

#결측치(NA) 데이터 처리
n1<- c(10,20,5,4,40,7,NA,6,3,NA,2,NA)
n1
mean(n1) # NA

#결측치 데이터 처리 함수
na <- function(x){ 
  cat("x값에 대한 평균 : ",mean(x, na.rm=TRUE),"\n")
  cat("x값에 대한 평균(소수점 2자리) : ",
        round(mean(x, na.rm=TRUE),2),"\n")
  ifelse(x>=0, x, NA) # 원소 출력
}
na(n1) #함수 호출

# ------------------------------------------------------------------- 
#<연습문제1> 
# ------------------------------------------------------------------- 


# ------------------------------------------------------------------- 
#<연습문제2> 
# ------------------------------------------------------------------- 


# 2. 주요 R 내장 함수 

seq(-2, 2, by=.2) # 0.2씩 증가
seq(length=10, from=-5, by=.2) # -5부터 10개 생성 
rnorm(20, mean = 0, sd = 1) # 정규분포를 따르는 20개 데이터 생성
runif(20, min=0, max=100) # 0~100사이의 20개 난수 생성
sample(0:100, 20) # 0~100사이의 20개 sample 생성
vec<-1:10
min(vec)
max(vec)
range(vec)
mean(vec) # 평균
median(vec) # 중위수
sum(vec) 
prod(vec) # 데이터의 곱

factorial(5) # 팩토리얼=120
abs(-5)  # 절대값
sd(rnorm(10)) # 표준편차 구하기 
table(vec) # 빈도수 
sqrt(16) # 4 
4^2 # 16
# 나머지 구하기
5%%3 # 2
6%%2 # 0


getwd()
setwd("c:/Rwork/Part-I")
excel <- read.csv("excel.csv", header=TRUE)
head(excel,10) 

#colMeans()함수 : 각 열의 평균 계산
colMeans(excel[1:5])

summary(excel)  


