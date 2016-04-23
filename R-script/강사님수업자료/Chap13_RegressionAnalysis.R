# Chap13_RegressionAnalysis

######################################################
# 회귀분석(Regression Analysis)
######################################################

#1. 상관관계 분석(Correlation Analysis)
# 변수 간 관련성 분석 방법

result <- read.csv("C:/Rwork/Part-IV/product.csv", header=TRUE)
head(result) # 친밀도 적절성 만족도(등간척도 - 5점 척도)

# 기술통계량
summary(result) # 요약통계량
# 표준편차  
sd(result$친밀도);sd(result$적절성);sd(result$만족도)

# 상관계수 보기
# 형식) cor(x, y, method) # x변수, y변수, method(pearson): 방법

cor(result$친밀도, result$적절성) # 0.4992086 -> 다소 높은 양의 상관관계
# ±0.9 ~ ±0.7: 관련성 높음, 적어도 ±6이상, 논문(±0.4)이상
cor(result$친밀도, result$만족도) # 0.467145 -> 다소 높은 양의 상관관계
cor(result$적절성, result$만족도) # 0.7668527

# 전체 변수 간 상관계수 보기
cor(result, method="pearson") # 피어슨 상관계수 - default

# 방향성 있는 색생으로 표현 - 동일 색상으로 그룹화 표시 및 색의 농도 
install.packages("corrgram")   
library(corrgram)
corrgram(result) # 색상 적용 - 동일 색상으로 그룹화 표시
corrgram(result, upper.panel=panel.conf) # 수치(상관계수) 추가(위쪽)
corrgram(result, lower.panel=panel.conf) # 수치(상관계수) 추가(아래쪽)


# 차트에 곡선과 별표 추가
install.packages("PerformanceAnalytics") 
library(PerformanceAnalytics) 
# 상관성,p값(*),정규분포 시각화 - 모수 검정 조건 
chart.Correlation(result, histogram=, pch="+") 

# spearman : 서열척도 대상 상관계수
cor(result, method="spearman")


#2. 회귀분석 
# 독립변수(x)가 종속변수(y)에 어떠한 영향을 미치는가 분석
# x변수를 대상으로 y변수 값(수치) 유추

# 1) 단순회귀분석 : 독립변수와 종속변수가 1개인 경우
# 연구가설 : 제품 적절성은 제품 만족도에 정(正)의 영향을 미친다.

# 연구모델 : x:  제품적절성(독립변수) -> y : 제품 만족도(종속변수)

# (1) 단순 선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data) # x:독립, y 종속, data=data.frame

str(result) # 'data.frame':  264 obs. of  3 variables:
y = result$만족도 # 종속변수
x = result$적절성 # 독립변수
head(x)
# 선형 회귀 모델 
result.lm <- lm(formula=y ~ x, data=result)
result.lm # 절편, 기울기 
# 회귀방정식 : y = a + bx(y : 종속, x:독립, a:절편, b:기울기)
# (Intercept)            x  
# 0.7789 : a       0.7393 : b
# y = 0.7789 + 0.7393 * 4
0.7789 + 0.7393 * 4 # 3.7361

# (2) 선형회귀 모델 결과 보기
summary(result.lm)


# (3) 단순선형회귀 시각화

plot(formula=y ~ x, data=result) # x,y 산점도 그리기 
result.lm <- lm(formula=y ~ x, data=result) # 회귀모형 생성
abline(result.lm, col='red') # 회귀선 추가


# [단순선형회귀분석 실습]
data(iris)
names(iris) # 5개 변수

# 조건1) 두 변수간의 상관성 - Sepal Length(꽃받침의 길이), Petal Width(꽃잎의 너비)
# 힌트 : cor(x, y)
cor(iris$Sepal.Length, iris$Petal.Width) # 0.8179411

# 조건2) 두 변수간의 상관성 - Sepal Length(꽃받침의 길이), Petal Length(꽃잎의 길이)
cor(iris$Sepal.Length, iris$Petal.Length) # 0.8717538

# 조건3) 선형회귀 모델 생성 
# Sepal.Length(종속변수), Petal.Length(독립변수)
result.lm <- lm(Sepal.Length ~ Petal.Length, data = iris)
# formula 속성은 생략 가능 
result.lm # 절편과 기울기 확인 : 
# 4.3066 : 절편,    0.4089 : 기울기 

# 조건4) 선형회귀 모델 결과보기
summary(result.lm) 

# 조건5) 선형회귀 모델 결과 해설(설명력, 속성의 예측력) 
# 모델의 설명력(R-squared) : 0.76 -> 76% : 높은 설명력
# 속성의 예측력 : 2e-16 *** : x 변수가 y에 영향을 미친다.


# 2) 다중회귀분석 : 여러 개의 독립변수 -> 종속변수에 미치는 영향 분석

# 연구가설 : 음료수 제품의 적절성과 친밀도는 제품 만족도에 양(+)의 영향을 미친다.
# 연구모델 : 제품 적절성, 제품 친밀도 -> 제품 만족도

# (1) 변수 모델링 : 적절성 + 친밀도 -> 만족도  
y <- result$만족도 # 종속변수
x1 <- result$적절성 # 독립변수
x2 <- result$친밀도 # 독립변수

# (2) 회귀모델 생성 
result.lm <- lm(formula=y ~ x1 + x2, data=result)
result.lm # 계수(절편과 기울기) 보기
# 0.66731(절편)      0.68522(x1)      0.09593(x2)  
# 회귀방정식 : Y(종속변수) = 절편 + 기울기1.x1 + 기울기2.x2...
# y = 0.66731 + 0.68522*x1 + 0.09593*x2

# (3) 회귀모델 결과 보기 
summary(result.lm) # 회귀모델 결과 보기 


########################################
###  학습데이터와 검정데이터 분석
########################################

# 단계1 : 7:3비율 데이터 샘플링
result <- read.csv("C:/Rwork/Part-IV/product.csv", header=TRUE) 
result
str(result) # 264 obs. of  3 variables:
t <- sample(1:nrow(result), 0.7*nrow(result))
t # 
264*0.7

# 단계2 : 학습데이터와 검정데이터 생성
train <- result[t,] # result중 70%
dim(train) # [1] 184   3
train # 학습데이터

test <- result[-t, ] # result중 나머지 30%
dim(test) # [1] 80  3
test # 검정 데이터

# 단계3 : 회귀모델 생성 :  학습 데이터 훈련 
model <- lm(만족도 ~ 적절성 + 친밀도, data=train)
model # 계수보기 - 절편,  기울기1, 기울기2 
summary(model) # 설명력, 속성 예측력 

# 단계4 : 회귀모델 평가 : 검정 데이터 이용 예측기 생성 
p <- predict(model, test) # test : y변수(만족도) 존재 

# 1) 상관계수로 성능 평가 
cor(p, test$만족도) # 0.7270783

# 2) 요약통계량 성능 평가 
summary(p);summary(test$만족도)

# ----------------------------------------------------------------
#<연습문제1>  다중회귀분석 수행
# ----------------------------------------------------------------
# ----------------------------------------------------------------
#<연습문제1> iris 데이터셋 대상으로 다음과 같이 다중회귀분석을 수행하시오.
data(iris)
str(iris) # 150 obs. of  5 variables:
#  조건1) 학습데이터(train),검증데이터(test)를 7 : 3 비율로 셈플링
idx <- sample(1:nrow(iris), nrow(iris)*0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
dim(train) # 105 5
dim(test) # 45 5

#  조건2) y변수 : Sepal.Length,  x변수 : Sepal.Width, Petal.Length, Petal.Width)
#  조건3) 1차분석 : train 데이터로 분석
model <- lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width,
            data=train)
model # 1.8537(절편) 0.6411(x1)   0.6936(x2) -0.4814(x3)
summary(model) # 모델 설명력, 속성 예측력 

#  조건3) 2차 분석 : test 데이터로 모델 평가
p <- predict(model, test)

#  조건4) 상관계수를 이용하여 회귀모델의 성능 평가
cor(p, test$Sepal.Length) # 0.9264939 
# 상관계수 r : 0.926으로 매우 높은 예측력을 보인다.

# 요약통계량으로 성능 평가 
summary(p); summary(test$Sepal.Length) # 매우 우수한 통계량 
# ----------------------------------------------------------------


# 3) 다중공선성(Multicolinearity) 문제 해결
# - 독립변수 간의 강한 상관관계로 인해서 회귀분석의 결과를 신뢰할 수 없는 현상
# - 생년월일과 나이를 독립변수로 갖는 경우
# - 해결방안 : 강한 상관관계를 갖는 독립변수 제거

# (1) 다중공선성 문제 확인
install.packages("car")
library(car)

fit <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Length+Petal.Width, data=train)
vif(fit)
sqrt(vif(fit))>2 # root(VIF)가 2 이상인 것은 다중공선성 문제 의심 

# (2) iris 변수 간의 상관계수 구하기
cor(iris[,-5]) # 변수간의 상관계수 보기(Species 제외) 
#x변수 들끼 계수값이 높을 수도 있다. -> 해당 변수 제거(모형 수정) <- Petal.Width

# (3) 학습데이터와 검정데이터 분류
x <- sample(1:nrow(iris), 0.7*nrow(iris)) # 전체중 70%만 추출
train <- iris[x, ] # 학습데이터 추출
test <- iris[-x, ] # 검정데이터 추출

# (4) 회귀모델 생성 : Petal.Width 변수를 제거한 후 모델 생성  
model_iris2 <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Length, data=train)
model_iris2 # 절편, 기울기(만약 기울기가 음수이면 음(-)의 영향) 

# 회귀모델 결과 보기 
summary(model_iris2) 

# 5) 회귀모델 성능 평가 
# 형식) predict(model, data) data에 y변수가 포함되어 있어야 함
p2 <- predict(model_iris2, test)# test에서 y변수를 찾아서 수치 예측 
p2 # test 대상 y값 예측 결과 

# 요약통계량으로 비교
summary(p2)
summary(test$Sepal.Length)


# 상관계수로 비교
cor(p2, test$Sepal.Length) #  0.8805379

# ----------------------------------------------------------------
#<연습문제2>  회귀방정식 적용 상품 구매 금액 예측
# ----------------------------------------------------------------
#<연습문제2> 3변수(구매횟수,쇼핑몰방문수,1회평균구매액)를 대상으로 
#            다중회귀 분석을 이용하여 총구매금액을 예측하시오.

# 데이터셋 가져오기 
result <- read.csv("C:/Rwork/Part-IV/regression.csv", header=F) 
head(result)

# 칼럼명 지정 : 총금액, 1회구매금액, 쇼핑몰방문수, 구매다양성 
names(result) <- c("total", "price", "period", "variety")
head(result)


# 조건1) 다중회귀분석 및 결과보기  
modle_reg <- lm(total ~ price + period + variety, data=result) 
modle_reg
cor(result)
#Coefficients:
#  (Intercept)      price       period            variety   
#     2.5457       0.4843    -0.4651(음의 영향)     0.6376  

# 조건2) 회귀분석 결과 해석 : 설명력, 속성 예측력(x1,x2,x3)
summary(modle_reg) # 회귀분석 결과 
###################<다중 회귀분석 결과 해설>####################
# 독립변수는 종속변수를 85%의 높은 설명력을 보이며,  3개 변수 모두
# p값이 유의수준 보다 작다. 따라서 price, veriety 변수는 
# total에 영향을 미친다고 볼 수 있다.
# 특히 구매금액과 상품구매 다양성은 총 거래금액에 정(+)의 영향의 미치지만,
# 쇼핑몰평균이용시간은 총 거래금액에 부(-)의 영향을 미친다.
###############################################################



