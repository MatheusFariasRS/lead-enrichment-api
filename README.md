# lead-enrichment-api

Backend project built with Java and Spring Boot to import, organize, and enrich lead data from CSV files using external APIs.

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

## API Docs & Monitoring

- `http://localhost:8080/docs`
- `http://localhost:8080/v3/api-docs`
- `http://localhost:8080/actuator/health`
- `http://localhost:8080/actuator/info`


## Project Goal

This project focuses on backend engineering practices such as data pipelines, external API integration, data enrichment, and system observability.
