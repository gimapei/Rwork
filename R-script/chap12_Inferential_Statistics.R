# chap12_Inferential_Statistics

####################################
#     점 추정과 구간 추정                              #
####################################
# 모수 : 모집단에 의해서 나온 통계량(모평균, 모표준편차)  
# 검정통계량 : 표본에 의해서 나온 통계량(표본평균, 표본표준편차)

# 추정(estimation) : 표본을 통해서 모집단을 확률적으로 추측   

# 1) 점 추정 : 제시된 한 개의 값과 검정통계량을 직접 비교하여 가설 기각유무 결정 
#  ex) 모집단의 평균 키(165.2cm)와 A학교 평균키 비교 

# 2) 구간 추정 : 제시된 신뢰구간과 검정통계량을 비교하여 가설 기각유무 결정 
#  신뢰구간 : 오차범위에 의해서 결정된 하한값과 상한값의 범위 


#############################################
# 추론통계분석 - 1-1. 단일집단 비율차이 검정
#############################################
# - 단일 집단의 비율이 어떤 특정한 값과 같은지를 검증

# 1. 실습데이터 가져오기
getwd()
setwd("c:/Rwork/Part-III")
data <- read.csv("one_sample.csv", header=TRUE)
head(data)
x <- data$survey


# 2. 빈도수와 비율 계산
summary(x) # 결측치 확인
length(x) # 150개
table(x) # 0:불만족(14), 1: 만족(136) 

install.packages("prettyR")
library(prettyR) # freq() 함수 사용
freq(x) 

# 3. 가설검정 

# 형식) binom.test(만족수, 불만족수, p = 확률)

# 1) 만족율 기준 검정
# 양측검정
binom.test(c(136,14), p=0.8) # 기존 80% 만족율 기준 검증 실시
binom.test(c(136,14), p=0.8, alternative="two.sided", conf.level=0.95)

# 단측검정
binom.test(c(136,14), p=0.8, alternative="greater", conf.level=0.95)


# 2) 불만족율 기준 검정
# 양측검정
binom.test(c(14,136), p=0.2) # 기존 20% 불만족율 기준 검증 실시
binom.test(c(14,136), p=0.2, alternative="two.sided", conf.level=0.95)

# ---------------------------------------------------------------------
# <단일집단 비율차이 검정 연습문제> 
# ---------------------------------------------------------------------

#############################################
# 추론통계분석 - 1-2. 단일집단 평균차이 검정
#############################################
# - 단일 집단의 평균이 어떤 특정한 값과 차이가 있는지를 검증

# 1. 실습파일 가져오기
setwd("c:/Rwrok/Part-III")
data <- read.csv("one_sample.csv", header=TRUE)
str(data) # 150
head(data)
x <- data$time
head(x)

# 2. 기술통계량 평균 계산
summary(x) # NA-41개
mean(x) # NA
mean(x, na.rm=T) # NA 제외 평균(방법1)

x1 <- na.omit(x) # NA 제외 평균(방법2)
mean(x1)

# 3. 정규분포 검정
# 정규분포(바른 분포) : 평균에 대한 검정 
# 정규분포 검정 귀무가설 : 정규분포와 차이가 없다.
# shapiro.test() : 정규분포 검정 함수


shapiro.test(x1) # 정규분포 검정 함수(p-value = 0.7242) 

# 4. 가설검정 - 모수/비모수
# 정규분포(모수검정) -> t.test()
# 비정규분포(비모수검정) -> wilcox.test()

# 1) 양측검정 - 정제 데이터와 5.2시간 비교
t.test(x1, mu=5.2) 
t.test(x1, mu=5.2, alter="two.side", conf.level=0.95) # p-value = 0.0001417
# 해설 : 평균 사용시간 5.2시간과 차이가 있다.

# 2) 단측검정 
t.test(x1, mu=5.2, alter="greater", conf.level=0.95) 
# p-value = 7.083e-05 = 0.00007083
# 해설 : A회사 노트북의 평균 사용시간은 5.2시간 보다 더 길다.

# ----------------------------------------------------------------
# <단일집단 평균차이 검정 연습문제> 
# ----------------------------------------------------------------


#############################################
# 추론통계분석 - 2-1. 두집단 비율차이 검정
#############################################

# 1. 실습데이터 가져오기
setwd("c:/Rwork/Part-III")
data <- read.csv("two_sample.csv", header=TRUE)
data
head(data) # 변수명 확인


# 2. 두 집단 subset 작성
data$method # 1, 2 -> 노이즈 없음
data$survey # 1(만족), 0(불만족)

# - 데이터 정체/전처리
x<- data$method # 교육방법(1, 2) -> 노이즈 없음
y<- data$survey # 만족도(1: 만족, 0:불만족)
x;y

# 1) 데이터 확인
# 교육방법 1과 2 모두 150명 참여
table(x) # 1 : 150, 2 : 150
# 교육방법 만족/불만족
table(y) # 0 : 55, 1 : 245

# 2) data 전처리 & 두 변수에 대한 교차분석
table(x, y, useNA="ifany") 


# 3. 두집단 비율차이검증 - prop.test()

# 양측검정
prop.test(c(110,135),c(150,150)) # 방법A 만족도와 방법B 만족도 차이 검정

prop.test(c(110,135),c(150,150), alternative="two.sided", conf.level=0.95)
# p-value = 0.0003422 - 두 집단간의 만족도에 차이가 있다.

# 단측검정
prop.test(c(110,135),c(150,150), alter="greater", conf.level=0.95)

# ----------------------------------------------------------------
# <두집단 비율차이 검정 연습문제> 
# ----------------------------------------------------------------

#############################################
# 추론통계분석 - 2-2. 두집단 평균차이 검정
#############################################

# 1. 실습파일 가져오기
data <- read.csv("c:/Rwork/Part-III/two_sample.csv", header=TRUE)
data 
head(data) #4개 변수 확인
summary(data) # score - NA's : 73개

# 2. 두 집단 subset 작성(데이터 정제,전처리)
result <- subset(data, !is.na(score), c(method, score))

result # 방법1과 방법2 혼합됨
length(result$score) # 227

# 3. 데이터 분리
# 1) 교육방법 별로 분리
a <- subset(result,method==1)
b <- subset(result,method==2)

# 2) 교육방법에서 점수 추출
a1 <- a$score
b1 <- b$score

# 3) 기술통계량 
length(a1); # 109
length(b1); # 118

# 4. 분포모양 검정 : 두 집단의 분포모양 일치 여부 검정

var.test(a1, b1) # p-value = 0.3002 -> 차이가 없다.
# 동질성 분포 : t.test()
# 비동질성 분포 : wilcox.test()

# 5. 가설검정 - 두집단 평균 차이검정
t.test(a1, b1)
t.test(a1, b1, alter="two.sided", conf.int=TRUE, conf.level=0.95)
# p-value = 0.0411 - 두 집단간 평균에 차이가 있다.

t.test(a1, b1, alter="greater", conf.int=TRUE, conf.level=0.95)
# p-value = 0.9794 : a1을 기준으로 비교 -> a1이 b1보다 크지 않다.
t.test(a1, b1, alter="less", conf.int=TRUE, conf.level=0.95)
# p-value = 0.02055 : a1이 b1보다 작다.

# ----------------------------------------------------------------
# <두집단 평균 차이 검정 연습문제>
# ----------------------------------------------------------------  

################################################
# 추론통계분석 - 2-3. 대응 두 집단 평균차이 검정
################################################
# 조건 : A집단  독립적 B집단 -> 비교대상 독립성 유지
# 대응 : 표본이 짝을 이룬다. -> 한 사람에게 2가지 질문
# 사례) 다이어트식품 효능 테스트 : 복용전 몸무게 -> 복용후 몸무게 

# 1. 실습파일 가져오기
getwd()
setwd("c:/Rwork/Part-III")
data <- read.csv("paired_sample.csv", header=TRUE)

# 2. 두 집단 subset 작성

# 1) 데이터 정제
result <- subset(data, !is.na(after), c(before,after))
# data 테이블을 대상으로 after 결측치 제거하여 subset 생성
result # 결측데이터 4개 

# 2) 적용전과 적용후 분리
x <- result$before# 교수법 적용전 점수
y <- result$after # 교수법 적용후 점수
x;y

# 3) 기술통계량 
length(x) # 96 -> 4개 결측치 제거
length(y) # 96
mean(x) # 5.16875
mean(y) # 6.220833 -> 1.052  정도 증가


# 3. 분포모양 검정 
var.test(x, y, paired=TRUE) 
# 동질성 분포 : t.test()
# 비동질성 분포 : wilcox.test()

# 4. 가설검정
t.test(x, y, paired=TRUE) # p-value < 2.2e-16 
# 단측검정 - 방향성 검정
t.test(x, y, paired=TRUE,alter="greater",conf.int=TRUE, conf.level=0.95) 
#p-value = 1 -> x을 기준으로 비교 : x가 y보다 크지 않다.
t.test(x, y, paired=TRUE,alter="less",conf.int=TRUE, conf.level=0.95) 
# p-value < 2.2e-16 -> x을 기준으로 비교 : x가 y보다 적다.

#<해설> 교수법 프로그램을 적용하기 전 시험성적과 교수법 프로그램을 적용한 후 
#시험성적을 비교한 결과 교수법을 적용한 후 시험성적이 약 1.052 점수가 향상된 
#것으로 나타났다.


# ----------------------------------------------------------------  
#<대응 두 집단 평균차이 검정 연습문제> 
# ---------------------------------------------------------------- 



############################################
# 추론통계분석 - 3-1. 세집단 비율차이 검정
############################################
# - 세집단 간 비율차이 검정

# 1. 파일가져오기 - 
getwd()
setwd("c:/Rwork/Part-III")
data <- read.csv("three_sample.csv", header=TRUE)
data

# 2. 세집단 subset 작성(데이터 정제,전처리) 
method <- data$method 
survey<- data$survey
method
survey 

# 3.기술통계량(빈도분석)
table(method, useNA="ifany") # 50 50 50 -> 3그룹 모두 관찰치 50개
table(method, survey, useNA="ifany") # 그룹별 클릭수 : 1-43, 2-34, 3-37


# 4. 세집단 비율차이 검정
# prop.test(그룹별 빈도, 그룹수) -> 집단이 늘어나도 동일한 함수 사용-땡큐
prop.test(c(34,37,39), c(50,50,50)) # p-value = 0.1165 -> 귀무가설 채택


############################################
# 추론통계분석 - 3-2. 세집단 평균차이 검정
############################################
# 세 집단 간 평균차분 분석 

# 1. 파일 가져오기
data <- read.csv("c:/Rwork/Part-III/three_sample.csv", header=TRUE)

# 2. 데이터 정제/전처리 - NA, outline 제거
data <- subset(data, !is.na(score), c(method, score)) 
data # method, score

# (1) 차트이용 - ontlier 보기(데이터 분포 현황 분석)
plot(data$score) # 차트로 outlier 확인 : 50이상과 음수값
barplot(data$score) # 바 차트
mean(data$score) # 14.45

# (2) outlier 제거 - 평균(14) 이상 제거
length(data$score)#91
data2 <- subset(data, score <= 14) # 14이상 제거
length(data2$score) #88(3개 제거)

# (3) 정제된 데이터 보기 
x <- data2$score
boxplot(x)
plot(x)

# 3. 세집단 subset 작성

# method: 1:방법1, 2:방법2, 3:방법3
data2$method2[data2$method==1] <- "방법1" 
data2$method2[data2$method==2] <- "방법2"
data2$method2[data2$method==3] <- "방법3"

table(data2$method2) # 교육방법 별 빈도수 

# 4. 동질성 검정 - 정규성 검정
# bartlett.test(종속변수 ~ 독립변수) # 독립변수(세 집단)
bartlett.test(score ~ method2, data=data2)

# 귀무가설 : 세 집단 간 분포의 모양이 동질적이다.
# 해설 : 유의수준 0.05보다 크기 때문에 귀무가설을 기각할 수 없다. 

# 동질한 경우 : aov() - Analysis of Variance(분산분석)
# 동질하지 않은 경우 - kruskal.test()

# 5. 분산검정(집단이 3개인 경우 분산분석이라고 함)
# aov(종속변수 ~ 독립변수, data=data set)

# 귀무가설 : 세집단의 평균에 차이가 없다.
result <- aov(score ~ method2, data=data2)
names(result) 

# aov()의 결과값은 summary()함수를 사용해야 p-value 확인 
summary(result) 
