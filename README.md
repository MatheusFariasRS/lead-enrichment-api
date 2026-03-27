# Ptax API

Backend project built with Java and Spring Boot to provide PTAX-related data through a structured REST API.

## Tech Stack

- Java
- Spring Boot
- PostgreSQL
- Flyway
- Redis
- Swagger / OpenAPI
- Spring Boot Actuator
- Docker Compose
- Testcontainers

## Running Locally

```bash
docker compose up -d
./mvnw spring-boot:run
```

## Useful Endpoints

- `http://localhost:8080/docs`
- `http://localhost:8080/v3/api-docs`
- `http://localhost:8080/actuator/health`
- `http://localhost:8080/actuator/info`