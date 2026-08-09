FROM tomcat:10.1-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY RestaurantDashboard.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 10000

CMD ["sh", "-c", "sed -i 's/<Server port=\"8005\" shutdown=\"SHUTDOWN\">/<Server port=\"-1\" shutdown=\"SHUTDOWN\">/' /usr/local/tomcat/conf/server.xml && PORT=${PORT:-10000} && sed -i \"s/port=\\\"8080\\\"/port=\\\"$PORT\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]