# Spidycoder 돌담길 프로젝트
# 서버

API Document  
http://test.rest.doldamgil.spidycoder.com:8080/swagger-ui.html

## 기능
- 클라이밍 센터 검색
- 에지 디바이스 제어
- 클라이밍 문제 출제, 검색, 관리
- 회원 가입

## 실행
JDK 11 required.

At the project root,
```shell script
./mvnw spring-boot:run
```

## application.yml 기본 설정
src/main/resources/application.yml
```yaml
spring:
  datasource:
    url: jdbc:mysql://db.doldamgil.spidycoder.com:3306/doldamgil?characterEncoding=UTF-8
    username: 
    password: 

server:
  tomcat:
    connection-timeout: 25000
    protocol-header: X-Forwarded-Proto
    remote-ip-header: X-Forwarded-For
```