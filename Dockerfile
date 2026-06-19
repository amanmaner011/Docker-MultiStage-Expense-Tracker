# Stage 1 - Build the JAR (java application runtime) using Maven
FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . .

# Create JAR file
RUN mvn clean install -DskipTests=true

# Stage 2 - Execute JAR file from the above stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/expensesapp.jar

CMD ["java", "-jar", "expensesapp.jar"]


