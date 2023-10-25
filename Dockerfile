FROM tomcat:9-jdk11
RUN apt-get update && apt-get install unzip wget -y

RUN wget https://github.com/glowroot/glowroot/releases/download/v0.14.0/glowroot-0.14.0-dist.zip -O /tmp/glowroot-0.14.0-dist.zip
RUN unzip /tmp/glowroot-0.14.0-dist.zip -d /tmp/
RUN mv /tmp/glowroot/ /opt/glowroot/

COPY resources/admin.json /opt/glowroot/

COPY resources/*.war /usr/local/tomcat/webapps/

ENV JAVA_OPTS="-javaagent:/opt/glowroot/glowroot.jar -Xmx1024m -Xss4096k -XX:MaxMetaspaceSize=100m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/shared"