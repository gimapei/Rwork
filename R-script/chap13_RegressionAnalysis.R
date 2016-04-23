# chap13_RegressionAnalysis

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
# 형식) cor(x,y, method) # x변수, y변수, method(pearson): 방법

cor(result$친밀도, result$적절성) # 0.4992086 -> 다소 높은 양의 상관관계
# ±0.9 ~ ±0.7: 관련성 높음, 적어도 ±6이상, 논문(±0.4)이상
cor(result$친밀도, result$만족도) # 0.467145 -> 다소 높은 양의 상관관계


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
# x변수를 대상으로 y변수 값 유추

# 1) 단순회귀분석 : 독립변수와 종속변수가 1개인 경우
# 연구가설 : 제품 적절성은 제품 만족도에 정(正)의 영향을 미친다.

# 연구모델 : 제품적절성(독립변수) -> 제품 만족도(종속변수)

# (1) 단순 선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data) # x:독립, y 종속, data=data.frame

str(result) # 'data.frame':  264 obs. of  3 variables:
y = result$만족도 # 종속변수
x = result$적절성 # 독립변수

result.lm <- lm(formula=y ~ x, data=result)
result.lm  # 절편, 기울기
# 회귀방정식 : y = a + bx ( y : 종속, x : 독립, a : 절편, b : 기울기 )

# 결과
#(Intercept)            x  
#0.7789       0.7393  

head(x)

# y = 0.7789 + 0.7393 * x(적절성)
y = 0.7789 + 0.7393 * 4
y

# (2) 선형회귀 모델 결과 보기
summary(result.lm)


# (3) 단순선형회귀 시각화

plot(formula=y ~ x, data=result) # x,y 산점도 그리기 
result.lm <- lm(formula=y ~ x, data=result) # 회귀모형 생성
abline(result.lm) # 회귀선 추가


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

# 회귀방정식 : Y(종속변수) = 절편 + 기울기1.x1 + 기울기2.x2...

# (3) 회귀모델 결과 보기 
summary(result.lm) # 회귀모델 결과 보기 


########################################
###  학습데이터와 검정데이터 분석
########################################

# 단계1 : 7:3비율 데이터 샘플링
result <- read.csv("C:/Rwork/Part-IV/product.csv", header=TRUE) 
result
t <- sample(1:nrow(result), 0.7*nrow(result))
t

# 단계2 : 학습데이터와 검정데이터 생성
train <- result[t,] # result중 70%
dim(train) # [1] 184   3
train # 학습데이터

test <- result[-t, ] # result중 나머지 30%
dim(test) # [1] 80  3
test # 검정 데이터

# 단계3 : 회귀모델 생성 :  학습 데이터 훈련 
model <- lm(formula=만족도 ~ 적절성 + 친밀도, data=train)
model # 계수보기  
summary(model)

# 단계4 : 회귀모델 평가 : 검정 데이터 이용 예측기 생성 
p<- predict(model, test)

# 상관계수로 성능 평가 
cor(p, test$만족도)

# ----------------------------------------------------------------
#<연습문제1>  다중회귀분석 수행
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

