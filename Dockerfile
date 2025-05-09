# Sử dụng Tomcat 10 làm base image
FROM tomcat:10.1-jdk21

# Chạy với quyền root để đảm bảo đủ quyền sao chép file
USER root

# Xóa tất cả ứng dụng mặc định (ROOT, examples,...)
RUN rm -rf /usr/local/tomcat/webapps/*

# Sao chép file WAR vào thư mục webapps
COPY target/restaurant-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# ⚠️ Sửa cổng Tomcat để đọc từ biến môi trường PORT của Railway
RUN sed -i 's/port="8080"/port="${PORT}"/g' /usr/local/tomcat/conf/server.xml

# Chạy Tomcat
CMD ["catalina.sh", "run"]
