# 1. 빌드 스테이지
FROM openjdk:21-jdk-slim AS build

# 2. 작업 디렉토리 설정
WORKDIR /app

# 3. 프로젝트 소스 코드 복사
COPY . .

# 4. Gradle Wrapper 실행 권한 부여
RUN chmod +x gradlew \
    && ./gradlew clean shadowJar --no-daemon

# 6. 실행 스테이지 (최종 실행 환경)
FROM openjdk:21-jdk-slim

# 7. 작업 디렉토리 설정
WORKDIR /app

# 8. 빌드된 JAR 파일 복사 (경로는 프로젝트에 따라 다를 수 있음)
COPY --from=build /app/build/libs/*.jar /app/app.jar

# 9. JAR 파일 실행 (경로 주의)
CMD ["java", "-jar", "/app/app.jar"]