FROM alpine:latest
ENV SECRET_KEY "mysecretkey"
ENV DATABASE_PASSWORD "password123"
LABEL AWS_TOKEN="thisisanawstoken"
#ARG HTTP_PROXY="http://user:pass@proxy.lon.example.com"
ADD https://archive.apache.org/dist/logging/log4j/2.14.1/apache-log4j-2.14.1-bin.tar.gz /root
RUN tar xzvf /root/apache-log4j-2.14.1-bin.tar.gz
