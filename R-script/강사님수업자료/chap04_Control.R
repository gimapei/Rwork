# chap04_Control

#####################################
# chap04_Control 수업 내용
#####################################

# 제어문 - 조건문과 반복문

# 1) if()함수
# 형식) 
# if(조건){
#   참인 경우
#}else{
#   거짓인 경우 
#}
x <- 10
y <- 5
z <- x * y
z

if(x*y < 40){
  cat("x*y의 결과는 40 이상입니다.\n")  # \n 줄바꿈
  cat("x*y =", z)
}else{
  cat("x*y의 결과는 40 미만입니다. x*y =", z,"\n")
}


# 학점 구하기
score <- scan()
score # 85

if(score >= 90){
  result="A학점"
}else if(score >=80){ # 80 ~ 89
  result="B학점"
}else if(score >=70){
  result="C학점"
}else if(score >=60){
  result="D학점"
}else{ # 4개 조건이 거짓인 경우 
  result="F학점"
}  
cat("당신의 학점은 ",result) 
print(result) 


# 2) ifelse(조건, 참, 거짓) - 3항 연산자 기능

ifelse(score>=80, "우수","노력") #우수

#ifelse() 응용
excel <-read.csv("c:/Rwork/Part-I/excel.csv", header = T)
q1 <- excel$q1 # q1 변수값 추출

ifelse(q1>=4, sqrt(q1),q1) #4보다 큰 경우 sqrt()적용

#논리연산자 적용
ifelse(q1>=2 & q1<=4, q1^2, q1) #1과 5만 출력, 나머지(2~4) 지수승


# 3) switch 문
# 형식) switch(비교구문, 실행구문1, 실행구문2, 실행구문3)

switch("id", id="hong", pwd="1234",age=105, name="홍길동")    

# 4) which 문
# which()의 괄호내의 조건에 해당하는 위치(인덱스)를 출력한다.

# 벡터에서 사용-> index값 리턴
name <- c("kim","lee","choi","park")
name[1]
which(name=="choi") # 3

# 데이터프레임에서 사용
no <- c(1:5)
name <-c("홍길동","이순신","강감찬","유관순","김유신")
score <- c(85,78,89,90,74)

exam <- data.frame(학번=no,이름=name,성적=score)
exam
which(exam$이름=="유관순") # 4


#####################################
# 2. 반복문
#####################################

# 1) 반복문 - for(변수 in 값) {표현식} 
i <- c(1:10) # 1 ~ 10
for(n in i){ # 10회 반복
  print(n * 10) # 계산식(numeric만 가능) 출력
  print(n)
}

for(n in i){
  if(n%%2==0) print(n) # %% : 나머지값 - 짝수만 출력
} 

for(n in i){
  if(n%%2==0){
    next # 짝수면 skip
  }else{
    print(n) # 홀수만 출력
  }    
} 


# 2) 반복문 - while(조건){표현식}
i = 0
while(i< 10){
  i <- i + 1 # 카운터 변수 
  print(i) # 1~10까지 출력됨
}

# 3) 반복문 - repeat{ 탈출조건 }
cnt <-1
repeat{ # 무한반복 
  print(cnt)
  cnt <- cnt + 2 
  if(cnt>15) break # cnt가 15보다 크면 탈출
}


# ---------------------------------------------------------------------   
#<데이터프레임 처리 관련 연습문제> 
# ---------------------------------------------------------------------   



