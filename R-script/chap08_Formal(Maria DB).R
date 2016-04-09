# chap08_Formal(Maria DB)


#chap08_Formal_InFormal 수업내용
# - 정형 데이터와 비정형데이터 처리


#1. 정형 데이터 처리 - Oracle DB 데이터 처리
# DB(RDB) 연결 - ODBC, JDBC, DBI
# - Oracle/MySql 실습


# Maria DB 정형 데이터 처리

# - DB(RDB) 연결 방법 : ODBC와 JDBC 방식
# ODBC(Open DataBase Connectivity) 연결방식 : DB 접속을 위해서 DB을 열어주는 API
# JDBC(Java DataBase Connectivity) 연결방식 : JAVA로 작성된 프로그램으로 DBMS에 연결하는 API
# -> 자바로 만들어진 R 패키지 프로그램으로 DBMS에 연결하기 위해서는 JDBC의 API를 지원하는 
# RJDBC 패키지를 설치하면 된다.

# DB 연결
# 1. RJDBC 패키지에서 제공되는 JDBC()함수를 이용하여 해당 DBMS의 driver 지정
# 2. dbConnect()함수에 4개 인수(driver,url,id,password)를 적용하여 DB에 연결 


# 패키지 설치
# - RJDBC 패키지를 사용하기 위해서는 우선 java를 설치해야 한다.
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC") # JDBC()함수 제공 

# 패키지 로딩
library(DBI)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_77')
library(rJava)
library(RJDBC) # rJava에 의존적이다.

################ MariaDB or MySql ###############
drv <- JDBC(driverClass="com.mysql.jdbc.Driver", 
            classPath="C:\\mysql-connector-java-5.1.38\\mysql-connector-java-5.1.38-bin.jar")

# driver가 완전히 로드된 후 db를 연결한다.
conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/work", "scott", "tiger")
######################################
# db 연결과정에 다음과 같은 error message가 출력되면 시스템을 재부팅 후 다시 연결한다.
#Error in .jcall(drv@jdrv, "Ljava/sql/Connection;", "connect", as.character(url)[1],  : 
#      java.lang.NoClassDefFoundError: Could not initialize class com.mysql.jdbc.Util
######################################                

# 1. 테이블의 컬럼 보기 
# 형식) dbListFields(con, "DBtable")

dbListFields(conn, "goods") # conn, table name

# 2. 테이블을 데이터프레임으로 가져오기 
# 형식) dbReadTable(con, "DBtable")
goods.db<- dbReadTable(conn, "goods")
goods.db


# 3. sql문 실행 - 전체 레코드 검색(select문)
query = "select * from goods"
goodsAll <- dbGetQuery(conn, query)
goodsAll

# 4. sql문 실행 - 조건 검색
query = "select * from goods where su >= 3"
goodsOne <- dbGetQuery(conn, query)
goodsOne


# 5. sql문 실행 - 정렬 검색 
query = "SELECT * FROM goods order by dan desc"
dbGetQuery(conn, query)


# 6. 데이터프레임 자료를 테이블에 저장 - 주의 : 기존 내용에 덮어쓰기 됨    
# 형식) dbWriteTable(con, "DBtable name", "Rdataframe")
insert.df <- data.frame(code=5, name='식기세척기', su=1, dan=250000)
insert.df
dbWriteTable(conn, "goods", insert.df) # 테이블에 기록 

# 테이블 조회 
query = "select * from goods"
goodsAll <- dbGetQuery(conn, query) 
goodsAll

# 7. 파일 자료를 테이블에 저장  - 주의 : 기존 내용에 덮어쓰기 됨  
# 형식) dbWriteTable(con, "DBtable name", "file name")
recode <- read.csv("c:/Rwork/Part-II/recode.csv") # 파일 자료 가져오기 
dbWriteTable(conn, "goods", recode) # 테이블에 기록

# 테이블 조회 
query = "select * from goods"
goodsAll <- dbGetQuery(conn, query) 
goodsAll


# 8. table 레코드 추가 
query = "insert into goods values(6,'test',1,1000)"
dbSendUpdate(conn, query) 

query = "select * from goods"
goodsAll <- dbGetQuery(conn, query) 
goodsAll

# 9 table 레코드 수정 
query = "update goods set name='테스트' where code=6"
dbSendUpdate(conn, query) 

query = "select * from goods"
goodsAll <- dbGetQuery(conn, query) 
goodsAll

# 10. table 레코드 삭제 
delquery = "delete from goods where code=6"
goodsInsert <- dbSendUpdate(conn, delquery) 

query = "select * from goods"
goodsAll <- dbGetQuery(conn, query) 
goodsAll


# 11. db연결 종료 
dbDisconnect(conn)


# 실습문제 code, name, su, dan

# 1) DB연결
library(DBI)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_77')
library(rJava)
library(RJDBC) # rJava에 의존적이다.

drv <- JDBC(driverClass="com.mysql.jdbc.Driver", 
            classPath="C:\\mysql-connector-java-5.1.38\\mysql-connector-java-5.1.38-bin.jar")

conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/work", "scott", "tiger")

query = "select code, name, su, dan, su*dan as 'su*dan' from goods"
temp.df <-dbGetQuery(conn, query) 
temp.df



