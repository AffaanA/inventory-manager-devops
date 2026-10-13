FROM gradle:8.10.2-jdk21 AS build

WORKDIR /app

COPY . .

RUN chmod +x gradlew
RUN ./gradlew --no-daemon bootJar -x test

FROM eclipse-temurin:21-jre

WORKDIR /app

RUN groupadd --system spring && useradd --system --gid spring spring

COPY --from=build /app/build/libs/*.jar app.jar

USER spring

EXPOSE 8083

ENTRYPOINT ["java", "-jar", "app.jar"]

