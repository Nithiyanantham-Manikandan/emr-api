FROM openjdk:17-jdk-slim
ENV APP_HOME=/app
WORKDIR $APP_HOME
COPY target/emr-api-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
