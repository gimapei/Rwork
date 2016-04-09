# chap05_Functions

# chap05_Function 수업내용
#  사용자 정의함수와 R 내장함수


# 형식)
# 변수 <- fucntion([매개변수])
# {
#     함수 수행문
#}

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

# 사칙연산 함수 정의
calc <- function(x,y,oper)
{
  if(oper == "+")
  {
    re <- x + y
  }
  else if(oper =="-")
  {
    re <- x - y
  }
  else if(oper =="*")
  {
    re <- x * y
  }
  else if(oper == "/")
  {
    re <- x / y
  }
  else
  {
    cat(" oper error !!! ")
  }
  cat("당신의 연산자는 : ",oper)
  cat("\n계산결과는 = ", re)
}
calc(10,4,"+")



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


# 특수문자 제거 --> 숫자 변환 함수
install.packages("stringr")
library(stringr)

test <- "100$"
test <- str_replace(test,"\\$","")
test
num <- as.numeric(test)
num <- num * 2
num

# ------------------------------------------------------------------- 
#<연습문제1> 
# ------------------------------------------------------------------- 


# ------------------------------------------------------------------- 
#<연습문제2> 
# ------------------------------------------------------------------- 

