# chap07_DataPreprocessing


# 1. 탐색적 데이터 분석

# 실습 데이터 읽어오기

setwd("C:/Rwork/Part-II")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우


#1) 데이터 셋 보기

# 데이터셋 전체 보기
print(dataset) 
View(dataset) # 뷰어창 출력

# 간단이 앞쪽/뒤쪽 조회
head(dataset) 
tail(dataset) 

# 2) 데이터 셋 구조보기
names(dataset) # 변수명(컬럼)
attributes(dataset) # names(), class, row.names
str(dataset) # 데이터 구조보기

# 3) 데이터 셋 조회 
dataset$age 
dataset$resident
length(dataset$age) # data 수-300개 

x <- dataset$gender # 조회결과 변수 저장
y <- dataset$price
x;y

plot(dataset$price) # 산점도 형태 전반적인 가격분포 보기

# $기호 대신 [""]기호를 이용한 변수 조회
dataset["gender"] 
dataset["price"]

# 색인(index)으로 변수의 위치값 조회
# dataset[행,열]

dataset[2] # 두번째 컬럼
dataset[6] # 여섯번째 컬럼
dataset[3,] # 3번째 관찰치(행) 전체
dataset[,3] # 3번째 변수(열) 전체

# dataset 데이터 중 변수를 2개 이상 조회하는 경우
dataset[1:10,c("job","price")]
dataset[c(2,6)] 

dataset[5,c(1,2,3)] 
dataset[5,c(1:3)] 
dataset[5,c(2,4:6,3,1)] 




# 2. 결측치 처리 - NA 

summary(dataset$price) 
sum(dataset$price) # NA 출력

# 결측데이터 제거 방법1
sum(dataset$price, na.rm=T) # 2362.9

# 결측데이터 제거 방법2 
price2 <- na.omit(dataset$price) 
sum(price2) # 2362.9
length(price2) # 270 -> 30개 제거


# 3. 극단치 발견과 정제

# 1) 범주형 변수 극단치 처리
gender <- dataset$gender
gender

# outlier 확인
hist(gender) # 히스토그램
table(gender) # 빈도수
pie(table(gender)) # 파이 차트

# gender 변수 정제(1,2)
data <- subset(dataset,dataset$gender==1 | dataset$gender==2)
data # gender변수 데이터 정제
length(data$gender) # 297개 - 3개 정제됨
pie(table(data$gender))


# 2) 비율척도 극단치 처리
dataset$price # 세부데이터 보기
length(dataset$price) #300개(NA포함)
plot(dataset$price) # 산점도 
summary(dataset$price) # 범위확인


# price변수 정제
data <- subset(dataset, dataset$price >= 2 & dataset$price <= 8)
length(data$price) 
stem(data$price) # 줄기와 잎 도표보기

# -------------------------------------------------------------
# <실습문제1> age 변수를 대상으로 outlier를 확인하시오.

# <실습문제2> age 변수를 대상으로 20~69세 범위로 정제하시오.
# -------------------------------------------------------------

#4. 역코딩 - 긍정순서(5~1)
data$survey
survey <- data$survey
csurvey <- 6-survey # 역코딩
csurvey
survey  # 역코딩 결과와 비교
data$survey <- csurvey # survery 수정
head(data) # survey 결과 확인

# -------------------------------------------------------------
# <실습문제3> 직급순서(1급 -> 5급, 5급 -> 1급)으로 역코딩 하시오.
# -------------------------------------------------------------

