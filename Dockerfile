# Use official maven image as the base image
FROM maven:alpine AS build

# Set working directory
WORKDIR /app

# Copy project files to working directory
COPY . .

# Build the project using Maven
RUN mvn clean install
# Use official ubuntu image as the base image
#FROM ubuntu:latest

# Set environment variables for MySQL database credentials
#ENV MYSQL_USER=myuser
#ENV MYSQL_PASSWORD=mypassword
#ENV MYSQL_DATABASE=mydb

# Install Apache and MySQL
#RUN apt-get update && \
 #   apt-get install -y apache2 mysql-server

# Copy the built project from the previous stage
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /app/

# Expose port 8080 for Apache
EXPOSE 8080

# Start Apache and MySQL on container startup
#CMD ["service", "apache2", "start"] && ["service", "mysql", "start"] && ["java", "-jar", "/app/my-app-1.0-SNAPSHOT.jar"]
CMD ["java", "-jar", "/app/my-app-1.0-SNAPSHOT.jar"]
