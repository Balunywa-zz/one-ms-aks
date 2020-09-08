
#First stage to build the application
FROM maven:3.5.4-jdk-11-slim AS build-env
LABEL maintainer="Lukman.Balunywa@microsoft.com"
ADD ./pom.xml pom.xml
ADD ./src src/
RUN mvn clean package

# build runtime image
#FROM openjdk:11-jre-slim
FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar

EXPOSE 80

#ENV SQL_USER="YourUserName" \
#SQL_PASSWORD="changeme" \
#SQL_SERVER="changeme.database.windows.net" \
#SQL_DBNAME="mydrivingDB"

# Add the application's jar to the container
COPY --from=build-env target/*.jar one-ms-aks.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/one-ms-aks.jar"]

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/one-ms-aks.jar"]
#testoneone