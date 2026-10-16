# STAGE 1: Use the builder container to ensure JAR exists
# This assumes the builder has built everything already

FROM sepehrfv/java23-maven:3.9.3 AS builder
# Same as in Dockerfile.build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# STAGE 2: Runtime image
FROM eclipse-temurin:23-jdk-alpine

WORKDIR /app

# Copy JAR from builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]