# class

# methods 패키지 

# member 클래스 생성 
setClass("member", 
         representation = list(
           name = "character",
           gender ="character",
           age = "numeric",
           salary ="numeric")
         )
# member 객체 생성 
hong <- new("member", name="홍길동", gender="남자", age=35, salary = 350)
hong

lee <- new("member", name="이순신", gender="남자", age=45, salary = 450)
lee

you <- new("member", name="유관순", gender="여자", age=25, salary = 400)
you

# 멤버 수정 
hong@age <- 38
hong

# class 내에 메서드 선언
setClass("car",
         representation = list(
         cc = "numeric",
         door = "numeric",
         name = "character")
         )
s1 <- new("car", cc=2500, door = 4, name="sonata")
s1

