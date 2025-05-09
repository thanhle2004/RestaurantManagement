# Sử dụng Tomcat 10 làm base image
FROM tomcat:10.1-jdk21

# Chạy với quyền root để đảm bảo đủ quyền sao chép file
USER root

# Xóa tất cả ứng dụng mặc định (ROOT, examples,...)
RUN rm -rf /usr/local/tomcat/webapps/*

# Sao chép file WAR vào thư mục webapps
COPY target/restaurant-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
