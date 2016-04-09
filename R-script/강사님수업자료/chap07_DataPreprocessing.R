# chap07_DataPreprocessing

# 1. 탐색적 데이터 분석

# 실습 데이터 읽어오기

setwd("C:/Rwork/Part-II")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우

dataset
#1) 데이터 셋 보기

# 데이터셋 전체 보기
print(dataset)
dataset
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
dim(dataset) # 300 7
# dataset[행,열]
dataset[2] # 두번째 컬럼
dataset[6] # 여섯번째 컬럼
dataset[3,] # 3번째 관찰치(행) 전체
dataset[,3] # 3번째 변수(열) 전체

# dataset 데이터 중 변수를 2개 이상 조회하는 경우
head(dataset[c("job","price")])
dataset[c(2,6)] # 2, 6열  

dataset[c(1,2,3)] 
dataset[c(1:3)] 
dataset[c(2,4:6,3,1)] 


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
# 변수 <- subset(data, 조건)
data <- subset(dataset, dataset$gender==1 | dataset$gender==2)
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
# 1-매우만족 2-만족 3-보통 4-불만족 5-매우불만족
# 1 ~ 5 -> 점수화  -> 6 - 코딩값 

data$survey
survey <- data$survey
head(survey) # 1 2 4 2 1 2
csurvey <- 6-survey # 역코딩
csurvey
survey  # 역코딩 결과와 비교
data$survey <- csurvey # survery 수정
data$survey[1:6] # 5 4 2 4 5 4

# -------------------------------------------------------------
# <실습문제3> 직급순서(1급 -> 5급, 5급 -> 1급)으로 역코딩 하시오.
# -------------------------------------------------------------


# 5. 코딩변경 - 나이 기준 변수 리코딩
summary(data$age)

data$age2[data$age <= 30] <-"청년층"
data$age2[data$age > 30 & data$age <=45] <-"중년층"
data$age2[data$age > 45] <-"장년층"
head(data[c('age', 'age2')])

#6.파생변수 생성 - 기존 데이터로 새로운 변수 생성
data$resident2[data$resident == 1] <-"특별시"
data$resident2[data$resident >=2 & data$resident <=4] <-"광역시"
data$resident2[data$resident == 5] <-"시구군"
head(data) # data 테이블 전체 - age2 컬럼 생성
head(data[c("resident","resident2")]) # 2개만 지정

# -------------------------------------------------------------
# <데이터 전처리 관련 연습문제>
# -------------------------------------------------------------


# 7.정제된 데이터 및 표본 셈플링
getwd()
setwd("c:/Rwork/Part-II")

# (1) 정제된 데이터 저장
write.csv(data,"cleanData.csv", quote=F, row.names=F) 

# (2) 저장된 파일 불러오기/확인
data <- read.csv("cleanData.csv", header=TRUE)
data 
length(data$age) # 길이 확인

# (3) 표본 셈플링 : 모집단 -> 표본추출 
?sample(x, size)
nrow(data) # 251
choice <- sample(1:nrow(data),30) # 30개 무작위 추출
choice # 추출값 : 행 번호
data[choice, ] # 관련 레코드 추출 

choice2 <- sample(nrow(data), 30) #sample과 동일
choice2
choice3 <- sample(50:nrow(data), 30) # 50~end
choice3
choice4 <- sample(c(50:100), 30) # 50~100
choice4

#다양한 범위를 지정해서 무작위 셈플링
choice5 <- sample(c(10:50, 70:150, 160:190),30)
choice5

# 마지막 행수 직접 입력
choicePrice <- sample(1:234,30) 
choicePrice # 셈플링 결과 


# 특정 변수 대상 셈플링 불가

data(iris)
str(iris) # 'data.frame':	150 obs. of  5 variables:
names(iris) # 붓꽃 
#[1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
#[5] "Species" 
table(iris$Species)
# setosa versicolor  virginica 
#   50         50         50 
head(iris)

# 문) iris 데이터 셋을 대상으로 7:3으로 샘플링 하시오.
#  <조건1> train 변수에 70% 데이터 저장 
#  <조건2> test 변수에 30% 데이터 저장 

# iris 전체 70%만 샘플링 
idx <- sample(1:nrow(iris), nrow(iris)*0.7)
train <- iris[idx, ] # 70% 데이터 
test <- iris[-idx, ] # 나머지 30% 데이터 
dim(train) # [1] 105   5
dim(test) # [1] 45  5






