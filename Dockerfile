FROM mariadb:latest

# mariadb-client install
RUN apt-get update && apt-get install -y mariadb-client