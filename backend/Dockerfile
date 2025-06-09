# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the Maven wrapper and pom.xml (if using Maven)
# COPY mvnw .
# COPY .mvn .mvn
# COPY pom.xml .

# Or copy the Gradle wrapper and build.gradle (if using Gradle)
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Grant execute permission for the wrapper
# RUN chmod +x mvnw
RUN chmod +x gradlew

# Download dependencies (optional, speeds up subsequent builds)
# RUN ./mvnw dependency:go-offline
RUN ./gradlew dependencies

# Copy the rest of the application source code
COPY src ./src

# Build the application
# RUN ./mvnw package -DskipTests
RUN ./gradlew build -x test

# Get the jar file from the build
# ARG JAR_FILE=target/*.jar
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} application.jar

# Expose the port the Spring Boot app runs on
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java","-jar","/app/application.jar"]
