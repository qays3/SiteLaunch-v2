FROM golang:1.20

WORKDIR /app

COPY ./src /app/src
COPY ./main.go /app
COPY ./scripts /app/scripts
COPY ./.env /app/.env
COPY ./docker/docker-compose.yml /app/docker/docker-compose.yml

RUN go build -o sitelaunch main.go

ENTRYPOINT ["./sitelaunch"]
