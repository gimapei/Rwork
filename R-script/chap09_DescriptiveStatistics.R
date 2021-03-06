# chap09_DescriptiveStatistics


# 1. 척도별 기술통계량

# 기술통계량의 유형 
# 대푯값 : 평균(Mean), 합계(Sum), 중위수(Median), 최빈수(mode), 사분위수(quartile) 등
# 산포도 : 분산(Variance), 표준편차(Standard deviation), 최소값(Minimum), 최대값(Maximum), 범위(Range) 등 
# 비대칭도 : 왜도(Skewness), 첨도(Kurtosis)

# - 실습파일 가져오기
setwd("c:/Rwork/Part-III")
data <- read.csv("descriptive.csv", header=TRUE)
head(data) # 데이터셋 확인

# 전체 데이터 특성 보기
dim(data) # 차원보기
length(data) # 열 길이
length(data$survey) # 컬럼 관찰치  
str(data) # 데이터 구조보기 
summary(data) # 요약통계량


# 1) 명목척도 변수의 기술통계량

length(data$gender) # 명목척도
summary(data$gender) # 명목척도 의미없음
table(data$gender) # 성별 빈도수 - outlier 확인(0, 5)

data <- subset(data,data$gender==1 | data$gender==2) # 성별 outlier제거
x <- table(data$gender) # 빈도수 저장
x 
str(x)
dim(x)
barplot(x) # 범주형 시각화 -> 막대차트

prop.table(x) # 빈도수 비율 계산
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)


# 2) 서열척도 변수의 기술통계량

length(data$level) # 학력수준 - 서열
summary(data$level) # 명목척도와 함께 의미없음
table(data$level)  # 빈도분석 - 의미있음

x1 <- table(data$level) # 각 학력수준에 빈도수 저장
x1 <- round(prop.table(x1)*100,2)
x1 
barplot(x1) # 명목/서열척도 -> 막대차트

# 3) 등간척도 변수의 기술통계량

survey <- data$survey
survey

summary(survey) # 만족도(5점 척도) -> 2.605(평균)
x1<-table(survey) # 빈도수
barplot(x1)
x1

hist(survey) # 등간척도 시각화 -> 히스토그림

# 4) 비율척도 변수의 기술통계량

length(data$cost)
summary(data$cost) # 요약통계량 - 의미있음(mean)
mean(data$cost) # NA
mean(data$cost, na.rm=T) # NA remove
data$cost
hist(data$cost)


# 데이터 정제 - 결측치 제거 및 outlier 제거
plot(data$cost)
data <- subset(data,data$cost >= 2 & data$cost <= 10) # 총점기준
data
x<- data$cost
x
plot(x)
hist(x)

##### cost 변수의 대푯값 ####
mean(x) # 평균 : 5.354
median(x) # 중위수 :  5.4   
sort(x) # 오름차순 
sort(x, decreasing=T) # 내림차순  
quantile(x, 1/4) # 1 사분위수 - 25%, 4.6
quantile(x, 3/4) # 3 사분위수 - 75%, 6.2
########################

#####################################
# 변량의 최빈수 구하기              #
#####################################

# 01. 연속형 난수 생성
x <- runif(100, min=1, max=100)
x

# 02. 이산형 데이터 변경
x1 <- round(x)  # 실수 -> 정수
x1
hist(x1)
range(x1)
barplot(x1)
plot(x1)
length(x1)

# 03. 빈도수 계산
mod <- table(x1)
mod
max(mod)

# 04. 최빈수 구하기
which(mod==5)
# 결과 ( 총 6개 숫자가 5번 반복된것임 )
# 75 85 97 
# 43 48 58 

#####################################


#### cost 변수의 산포도 #####
# 산포도 : 대표값으로부터 얼마나 흩어져 있는지를 살펴보는 통계량

var(x) # 분산
# [1] 1.296826

sd(x) # 표준편차는 분산의 양의 제곱근
# [1] 1.138783 

sqrt(var(x))  # 표준편차는 분산의 양의 제곱

min(x) # 최소값
max(x) # 최대값
range(x) # 범위(min ~ max)
#########################

# 연속형(등간/비율척도) 시각화 : 히스토그램 의미없음
# 연속형변수는 교차분석이 불가하다, 범주형 변수로 변경해야 한다. 
table(data$cost) # cost 빈도수
hist(data$cost) #  

# 연속형 -> 범주화(리코딩) : 1,2,3
names(data)
data$cost2[data$cost >=1 & data$cost <4] <-1    # cost의 값이 1 ~ 3
data$cost2[data$cost >=4 & data$cost <7] <-2    # cost의 값이 4 ~ 6
data$cost2[data$cost >=7] <-3                    # cost의 값이 7이상

head(data[c("cost", "cost2")], 10)

hist(data$cost2)


# 5) cost 비율척도 기술통계량 구하기
attach(data) #data를 붙여라!      
length(cost)
summary(cost) # 요약통계량 - 의미있음(mean)
mean(cost) # 가장 의미있음
min(cost)
max(cost)
range(cost) # min ~ max
sort(cost) # 오름차순 
sort(cost, decreasing=T) # 내림차순
detach(data) # attach(data) 해제

# NA가 있는 경우 -> NA 출력
test <-c(1:5,NA,10:20)
test
min(test) 
max(test) 
range(test) 
mean(test)   

# 결측치 데이터 제거 후 통계량 구하기
min(test, na.rm=T) 
max(test, na.rm=T)
range(test, na.rm=T) 
mean(test, na.rm=T)

# 6) 비대칭도 구하기
# 비대칭도 : 분포의 기울어진 방향의 정도와 중심에 집중되는 정도를 나타내는 척도  

install.packages("moments")  # 왜도/첨도 사용을 위한 패키지 설치   
library(moments)
cost <- data$cost     

# 왜도
skewness(cost) # 0보다 작으면 왼쪽 꼬리, 크면 오른쪽 꼬리


# 첨도 
kurtosis(cost) # 2.683438   # 정규분포 첨도는 3  

hist(cost) # 히스토그램으로 왜도/첨도 확인

# 시각화를 통해서 정규분포 확인 : 상기 histograph에 정규분포 추가

hist(cost, freq = F)
lines(density(cost), col="red")

# 정기분포 곡선
x <- seq(0,8,0.1)
x
curve(dnorm(x, mean(cost), sd(cost)), col="blue", add=T)

# 검정방법으로 정규분포 확인 
# 귀무가설 : 정규분포와 차이가 없다. ( 부정표현 )
# 대립가설 : 정규분포와 차이가 있다. ( 긍정표현 )

shapiro.test(cost)
# 결과 data:  cost
# W = 0.98187, p-value = 0.002959

# 해석방법
# p < 알파(0.05)  :  귀무가설을 기각한다. 즉 대립가설을 채택 
# 따라서 결과가 0.002959로 0.05보다 작으므로 귀무가설을 기각하고 정규분포와 차이가 있다를 채택
# 즉 정규분포가 아니다 로 판단된다. 


#  2. 패키지 이용 기술통계량 구하기     

########################<기술통계 패키지1>######################
install.packages("Hmisc") # 패키지 설치
library(Hmisc) # 메모리 로딩

# 전체 변수 대상 기술통계량 제공 - 평균,중위수,분산,표준편차,valid.n 
describe(data) # Hmisc 패키지에서 제공되는 함수

# 개별 변수 기술통계량
describe(data$gender) # 명목척도 
describe(data$age) # 비율척도
##############################################################

########################<기술통계 패키지2>#######################
install.packages("prettyR")
library(prettyR)

# 전체 변수 대상 기술통계량 제공     
freq(data) # 각 변수별 : 빈도수, 결측치(NA), 백분율
# 개별 변수 대상
freq(data$gender) # 빈도수, 결측치(NA), 비율 
###############################################################

# --------------------------------------------------------------------------
# <기술통계량 분석 관련 연습문제>
# --------------------------------------------------------------------------

# <연습문제1> MASS 패키지에 있는 Animals 데이터 셋을 이용하여 각 단계에 맞게 기술통계량을 구하시오.

# [단계 1] MASS 패키지 설치 및 메모리 로딩
install.packages("MASS")
library(MASS) # MASS 패키지 불러오기
data(Animals) # Animals 데이터셋 로딩
head(Animals) # Animals 데이터셋 보기

# [단계 2] R의 기본함수를 이용하여 brain 칼럼을 대상으로 다음 기술통계량 구하기
# Animals 데이터 셋 차원보기 
m <- Animals
dim(m)

# 요약통계량 
summary(m)
attach(m)
summary(brain)

# 평균
mean(brain)
mean(body)

# 중위수
median(brain)
median(body)

# 표준편차
sd(brain)
sd(body)

# 분산
var(body)
var(brain)

# 최댓값
max(body)
max(brain)

# 최솟값
min(body)
min(brain)

# [단계 3] 패키지에서 제공되는 describe()과 freq()함수를 이용하여 
# Animals 데이터 셋 전체를 대상으로 기술통계량 구하기
describe(m)
freq(m)




#  3. 기술통계량 보고서 작성법

# 1) 거주지역 
data$resident2[data$resident == 1] <-"특별시"
data$resident2[data$resident >=2 & data$resident <=4] <-"광역시"
data$resident2[data$resident == 5] <-"시구군"

head(data[c("resident", "resident2")],10)

x<- table(data$resident2)
prop.table(x) # 비율 계산 
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)


# 2) 성별
data$gender2[data$gender== 1] <-"남자"
data$gender2[data$gender== 2] <-"여자"
x<- table(data$gender2)

prop.table(x) # 비율 계산 
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)


# 3) 나이
summary(data$age)# 40 ~ 69
data$age2[data$age <= 45] <-"중년층"
data$age2[data$age >=46 & data$age <=59] <-"장년층"
data$age2[data$age >= 60] <-"노년층"
x<- table(data$age2)
x
prop.table(x) # 비율 계산 
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)


# 4) 학력수준
data$level2[data$level== 1] <-"고졸"
data$level2[data$level== 2] <-"대졸"
data$level2[data$level== 3] <-"대학원졸"

x<- table(data$level2)
prop.table(x) # 비율 계산 
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)

# 5) 합격여부
data$pass2[data$pass== 1] <-"합격"
data$pass2[data$pass== 2] <-"실패"
y<- table(data$pass2)
y
prop.table(x) # 비율 계산
y <-  prop.table(x)
round(y*100, 2) #백분율 적용(소수점 2자리)

head(data)

describe(data)
summary(data$cost) 
sum(data$cost) 

describe(data)
summary(data$survey) 
sum(data$survey, na.rm=T) 

# <논문/보고서 에서 표본의 인구통계적특성 결과 제시 방법>


# 기술통계량 정제 데이터 저장 
getwd()
setwd("c:/Rwork/Part-III")
write.csv(data,"cleanDescriptive.csv", quote=F, row.names=F) # 행 이름 제거

# --------------------------------------------------------------------------
# <빈도분석 및 기술통계량 분석 관련 연습문제>
# --------------------------------------------------------------------------


# <연습문제2> descriptive.csv 데이터 셋을 대상으로 
# 다음 조건에 맞게 빈도분석 및 기술통계량 분석을 수행하시오.
setwd("c:/Rwork/Part-III")
data <- read.csv("descriptive.csv", header=TRUE)

head(data)
str(data)


# [조건 1] 명목척도 변수인 학교유형(type), 합격여부(pass) 변수에 대해 
# 빈도분석을 수행하고 결과를 막대그래프나 파이차트로 그리시오.
data$type2[data$type== 1] <-"국립"
data$type2[data$type== 2] <-"사립"
data$pass2[data$pass== 1] <-"합격"
data$pass2[data$pass== 2] <-"불합격"

type2_ <- table(data$type2)
barplot(type2_)

pass2_ <- table(data$pass2)
pie(pass2_)

# [조건 2] 비율척도 변수인 나이 변수에 대해 요약치(평균, 표준편차)와 
# 비대칭도(왜도와 첨도)통계량을 구하고, 히스토그램 작성하여 비대칭도 통계량을 설명하시오.
age <- data$age
range(age)
mean(age)
ad(age)

library(moments)
skewness(age)
kurtosis(age)
hist(age)
