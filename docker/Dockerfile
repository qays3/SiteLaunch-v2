FROM golang:1.18

WORKDIR /app

COPY . .

RUN go build -o sitelaunch main.go

CMD ["./sitelaunch"]