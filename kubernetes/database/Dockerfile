FROM mariadb:10.3

ENV MYSQL_ROOT_PASSWORD sa

COPY V0.1.0__initial.sql /docker-entrypoint-initdb.d/
COPY V0.2.0__sample_data.sql /docker-entrypoint-initdb.d/
