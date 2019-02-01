FROM openjdk:8-jdk

VOLUME /tmp

ADD spring-boot-sample-hateoas-*.jar /app/app.jar

ENTRYPOINT [ "sh", "-c", "java -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar" ]

EXPOSE 8090
