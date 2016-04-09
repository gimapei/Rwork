# chap02_DataPreprocessing (연습문제정답)


# <실습문제1> age 변수를 대상으로 outlier를 확인하시오.
summary(data$age) # Min(20), Max(69), NA(16)
length(data$age) # 251

# <실습문제2> age 변수를 대상으로 20~69세 범위로 정제하시오.
data <- subset(data,data$age >= 20 & data$age <= 69)
length(data$age) # 235개(16 정제)
# box 플로팅으로 평균연령 분석
boxplot(data$age) # 45대 중반 평균 연령


# <실습문제3> 직급순서(1급 -> 5급, 5급 -> 1급)으로 역코딩 하시오.
# position 대상 5->1, 1->5로 역코딩하여 position 변수 수정
data$position
position <- data$position
cposition <- 6-position
cposition
position  # 역코딩 결과와 비교
data$position <- cposition # data set에 position 변수 수정
head(data) # position 결과 확인


# <연습문제>
# 1. resident변수의 NA 값을 제거한 후 data 변수에 저장하시오.
data <- subset(data,data$resident >= 1 & data$resident <= 5)
length(data$resident)

# 2. gender변수를 대상으로 1 -> 남자, 2 -> 여자 형태로 리코딩하여 
#    gender2변수에 추가한 후 파이차트로 결과를 확인하시오.
data$gender2[data$gender == 1] <- "남자"
data$gender2[data$gender == 2] <- "여자"
pie(table(data$gender2))

# 3. 나이를 30세 이하-> 1, 30~45-> 2, 45이상-> 3 으로 리코딩하여
#    age3변수에 추가한 후 age, age2, age3 변수 3개만 확인하시오.
data$age3[data$age <= 30] <-1
data$age3[data$age > 30 & data$age <=45] <-2
data$age3[data$age > 45] <-3
head(data[c("age","age2", "age3")]) # 3개만 지정
