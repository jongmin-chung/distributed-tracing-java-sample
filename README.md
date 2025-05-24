### Distributed Tracing Java Sample

This project demonstrates how to implement distributed tracing in java spring boot application with the help for below microservices

- [order-service](order-service)
- [payment-service](payment-service)
- [user-service](user-service)

### Tracing flow

![Distributed tracing](applicationflow.png)

### Running the code

This application require Eureka service registry

```bash
cd discovery-server && \
mvn clean install -Dmaven.test.skip && \
docker build -t discovery-service:1.0.1 . && \
docker run -d --name discovery-service -p 8761:8761 discovery-service:1.0.1
```

Run `http://localhost:8761`

![Eureka](eureka.png)

Start individual microservice using below commands

## Prerequisites

- Java 8
- Maven (`brew install maven`)


0. Infrastructure

```bash
$ git clone -b main https://github.com/SigNoz/signoz.git && \
cd signoz/deploy/docker && \
docker compose up -d --remove-orphans
```

```bash
docker run --name mysql-signoz \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  -e MYSQL_DATABASE=signoz \
  -p 3307:3306 \
  -d mysql:latest
```

1. UserService

```bash
cd user-service && \
mvn clean install -Dmaven.test.skip 
sh ./scripts/start.sh

```

2. OrderService

```bash
cd order-service
mvn clean install -Dmaven.test.skip
sh ./scripts/start.sh

```

3. PaymentService

```bash
cd payment-service && \
mvn clean install -Dmaven.test.skip && \
sh ./scripts/start.sh

```

4. Demo UI

To capture traces from above microservice run the [sample-ui](ui) application using below commands

```bash
cd ui && \
pnpm install && \
pnpm run dev
````

Open http://localhost:9090 and perform actions that will capture traces to signoz

![DemoUI](demo-ui.png)

View traces, logs and metrics:

- View the metrics in signoz, go to http://localhost:3301/application


## 자원 정리

```bash
cd signoz/deploy/docker && \
docker compose down -v && \
docker stop mysql-signoz && \
docker stop discovery-service
```
