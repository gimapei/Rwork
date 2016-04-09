#II. 데이터 분석과 모델링

# chap06_DataVisualization (연습문제정답)


# <연습문제>  iris 데이터 테이블을 대상으로 plot()함수를 이용하여 
#             다음 조건에 맞게 차트를 그리시오.


# 조건1) 1번 컬럼이 x축, 3번 컬럼을 y축으로 차트 그리기
plot(iris[,1], iris[,3])
# 내용 추가
plot(iris$Sepal.Length, iris$Petal.Length, col="red") # 모두 빨강색

# 조건2) 5번 컬럼으로 색상 지정하기
plot(iris[,1], iris[,3], col=iris[,5])  # 5컬럼으로 색상 구분
names(iris)
plot(iris$Sepal.Length, iris$Petal.Length, col=iris$Species)

# 조건3) 제목 추가("iris 데이터 테이블 산포도 차트")
plot(iris$Sepal.Length, iris$Petal.Length, col=iris$Species)
title(main="iris 데이터 테이블 산포도 차트")

# 내용 추가
plot(iris) # iris 데이터를 대상으로 제공되는 모든 차트 그려줌
plot(iris[, -5], col=iris[,5]) # 5번컬럼 제거, 색지정으로 사용
title(main="다양한 차트")

# 조건4) 파일로 차트 저장하기("C:/Rwork/Part-II/iris.jpg")
setwd("C:/Rwork/Part-II") # 폴더 지정
jpeg("iris.jpg", width=720, height=480) # 픽셀 지정 가능
plot(iris$Sepal.Length, iris$Petal.Length, col=iris$Species)
title(main="iris 데이터 테이블 산포도 차트")
dev.off() # 장치 종료 - "c:/Rwork/Part-II" <- 이미지 파일 확인

