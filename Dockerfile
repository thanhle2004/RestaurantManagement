# --- Stage 1: Build the WAR using Maven ---
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app

# Copy all project files
COPY . .

# Build the WAR file
RUN mvn clean package -DskipTests

# --- Stage 2: Deploy to Tomcat ---
FROM tomcat:10.1-jdk21

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR as ROOT.war
COPY --from=build /app/target/restaurant-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]
