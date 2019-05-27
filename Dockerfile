FROM maven:3.6.1-jdk-8-slim

LABEL maintainer="akhil.bojedla.developer@gmail.com"
LABEL version="1.0.0"

RUN mkdir -p /app
WORKDIR /app

COPY . .

RUN mvn clean package


FROM openjdk:8-jre-slim

LABEL maintainer="akhil.bojedla.developer@gmail.com"
LABEL version="1.0.0"

EXPOSE 8080

RUN mkdir -p /opt/jsonblobs/
RUN mkdir /app
WORKDIR /app

VOLUME /opt/jsonblobs

COPY --from=0 /app/target/jsonblob.jar .
COPY --from=0 /app/target/config/jsonblob.yml .

ENTRYPOINT [ "java", "-Ddw.blobManager.fileSystemBlogDataDirectory=/opt/jsonblobs/", "-jar", "/app/jsonblob.jar", "server",  "/app/jsonblob.yml"]