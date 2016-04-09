# chap05_Function (연습문제정답)


#######################################################
#<연습문제1> 다음 income 객체에서 날짜별 자판기의 코인 수가 2이상이면 
#     "수입금 GOOD", 그렇지 않으면 "수입금 Bad"를 출력하는 사용자 정의함수를
#      작성하시오.
income <- c("2015-02-05 income1coin", "2015-02-06 income2coin", 
            "2015-02-07 income3coin")

#  힌트) 사용 함수 : stringr 패키지 : str_extract(), str_replace()함수
#                         base 패키지 : 숫자변환 -> as.numeric()함수 


library(stringr) # 패키지 로드 
vending <- function(x) {
  print(x) # income 벡터값 출력
  for(i in x){
    coin = str_extract(i, "[0-9]{1}[a-z]{4}") # 동전수
    coin = str_replace(coin, "[a-z]{4}","") # 문자열4개 제거
    coin = as.numeric(coin) # 숫자 변경(연산가능)
    print(coin)
    if(coin >= 2){ # 조건
      print("수입금 Good")
    }else{
      print("수입금 Bad")
    }
  }
}
vending(income)

#<연습문제2> 함수 y = f(x)에서 x의 값이 a에서 b까지 변할 때
#            △x = b - a를 x의 증분이라고 한다.
#            △y = f(b) - f(a)를 y의 증분이라고 한다.
#            평균변화율 = △y/△x  =  f(b) - f(a)/ b-a
#  조건) 함수 f(x) = x^3 + 4에서 x의 값이 1에서 3까지 변할 때
#        평균변화율(mean ratio of change)을 구하는 함수를 작성하시오. 
#        mrc = 31-5/2 = 13

f <- function(x){
  x <- x^3 + 4
}
a <- 1
b <- 3

mrc <- {f(b)-f(a)}/{b-a}
mrc
