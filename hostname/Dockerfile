FROM golang

RUN mkdir /go/src/hostname
COPY ./hostname.go /go/src/hostname
RUN go install hostname
ENTRYPOINT /go/bin/hostname
 
EXPOSE 80
