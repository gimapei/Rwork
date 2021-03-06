# chap15_ClusteringAnalysis

###################################################
# 군집분석(Clustering)
###################################################

# 1. 유클리드 거리
# 유클리드 거리(Euclidean distance)는 두 점 사이의 거리 계산

# (1) matrix 생성
x <- matrix(1:9, nrow=3, by=T) 
x

# (2) matrix 대상 유클리드 거리 생성 함수
# 형식) dist(x, method="euclidean") -> x : numeric matrix, data frame
dist <- dist(x, method="euclidean") # method 생략가능
dist

# (3) 유클리드 거리 계산 식
# 관측대상 p와 q의 대응하는 변량값의 차의 제곱의 합에 sqrt 적용


# 2. 계층적 군집분석(Hierarchical Clustering)
# - 거리가 가장 가까운 대상부터 결합하여 나무모양의 
#   계층구조를 상향식(Bottom-up)으로 만들어가면서 군집을 형성 

# (1) 군집분석(Clustering)분석을 위한 패키지 설치
install.packages("cluster") # hclust() : 계층적 클러스터 함수 제공
library(cluster) # 일반적으로 3~10개 그룹핑이 적정

# (2) 데이터 셋 생성
x <- matrix(1:9, nrow=3, by=T) 
x

# (3) matrix 대상 유클리드 거리 생성 함수
dist <- dist(x, method="euclidean") # method 생략가능
dist

# (4) 유클리드 거리 matrix를 이용한 클러스터링
hc <- hclust(dist) # 클러스터링 적용
hc

plot(hc) # 클러스터 시각화(Dendrogram) -> 1과2 군집(클러스터) 형성

#<실습> 중1학년 신체검사 결과 군집분석
#-------------------------------------
body <- read.csv("c:/Rwork/Part-Iv/bodycheck.csv", header=TRUE)

idist<- dist(body[, -1]) # 유클리드 거리 생성

hc <- hclust(idist) # 클러스터링
hc

plot(hc, hang=-1) # 음수값 제외 클러스터링 시각화

# 3개 그룹 선정, 선 색 지정
rect.hclust(hc, k=3, border="red") # 3개 그룹 선정, 선 색 지정

# 각 그룹별 서브셋 만들기
g1<- subset(body, 번호==10| 번호==4| 번호==8| 번호==1 | 번호==15)
g2<- subset(body, 번호==11| 번호==3| 번호==5| 번호==6 | 번호==14)
g3<- subset(body, 번호==2| 번호==9| 번호==13| 번호==7 | 번호==12)

#--------------------------------------------------------------------
# <연습문제1> 계층적 군집분석
#--------------------------------------------------------------------



# 3. 계층형 군집분석에 그룹수 지정
# - 계층형 군집분석 결과에 그룹수를 지정하여 클러스터별 기술통계량 구하기

# 1) 유클리드 거리 계산 : 
idist<- dist(iris[1:4]) # 꽃받침 길이와 넓이, 꽃잎의 길이와 넓이, 꽃의 종류 제외 

# 2) 계층형 군집분석(클러스터링)
hc <- hclust(idist)
hc 
plot(hc, hang=-1) # 음수값 제외
rect.hclust(hc, k=4, border="red") # 4개 그룹으로 분류 

# 3) 그룹수 만들기 : 기본함수 cutree() 이용 
#형식) cutree(계층형군집결과,  k =그룹수) 
ghc<- cutree(hc, k=3) # stats 패키지 제공 

ghc 

# 4) iris에서 ghc 컬럼 추가
iris$ghc <- ghc
table(iris$ghc) # ghc 빈도수

head(iris,60) # ghc 칼럼 확인 

# 5) 그룹별 요약통계량 구하기
g1 <- subset(iris, ghc==1)
summary(g1[1:4])

g2 <- subset(iris, ghc==2)
summary(g2[1:4])

g3 <- subset(iris, ghc==3)
summary(g3[1:4])


# 4. 비계층적 군집분석(확인적 분석)
# - 군집 수를 알고 있는 경우 이용하는 군집분석 방법
# - 군집분석 종류 : 계층적 군집분석(탐색적), 비계층적 군집분석(확인적) 

# 1) data set 준비 
library(ggplot2)
data(diamonds)

nrow(diamonds) 
t <- sample(1 : nrow(diamonds), 1000) # 1000개 셈플링 

test <- diamonds[t, ] # 1000개 표본 추출
dim(test) 

head(test) # 검정 데이터
mydia <- test[c("price","carat", "depth", "table")] # 4개 칼럼만 선정
head(mydia)

# 2) 계층적 군집분석(탐색적 분석)
result <- hclust(dist(mydia), method="average") # 평균거리 이용 
result

plot(result, hang=-1) # hang : -1 이하 값 제거

# 3) 비계층적 군집분석(확인적 분석) - kmeans()함수 이용
# - 확인적 군집분석 : 군집의 수를 알고 있는 경우
result2 <- kmeans(mydia, 3)
result2 

names(result2) 
result2$cluster # 각 케이스에 대한 소속 군집수(1,2,3)

# 4) 원형데이터에 군집수 추가
mydia$cluster <- result2$cluster
head(mydia) 

# 5) 변수 간의 상관성 보기 
plot(mydia[,-5])
cor(mydia[,-5], method="pearson") # 상관계수 보기 

library(corrgram) # 상관성 시각화 
corrgram(mydia[,-5]) # 색상 적용 - 동일 색상으로 그룹화 표시
corrgram(mydia[,-5], upper.panel=panel.conf) # 수치(상관계수) 추가(위쪽)


# 6) 비계층적 군집시각화
plot(mydia$carat, mydia$price)
plot(mydia$carat, mydia$price, col=mydia$cluster)

# 각 그룹의 중심점에 포인트 추가 
points(result2$centers[,c("carat", "price")], col=c(3,1,2), pch=8, cex=5)

#-----------------------------------------------------------
#<연습문제2> 제품 판매 실적 데이터 군집분석
#-----------------------------------------------------------


