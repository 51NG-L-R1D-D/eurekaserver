#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM adoptopenjdk/openjdk11:alpine-slim
COPY --from=build /home/app/target/eurekaserver-0.0.1-SNAPSHOT.jar app/app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar","/app/app.jar"]