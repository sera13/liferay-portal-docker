FROM openjdk:8-jdk-slim

ARG LIFERAY_HOME
ARG CATALINA_HOME

RUN cd /opt \
    && apt-get update \
    && apt-get install -y  curl telnet tree nano iputils-ping p7zip wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -ms /bin/bash liferay


COPY  ./configs/common/liferay-ce-portal-tomcat-7.2.1-ga2-20191111141448326.7z .
RUN p7zip --decompress liferay-ce-portal-tomcat-7.2.1-ga2-20191111141448326.7z \
&& mv liferay-ce-portal-7.2.1-ga2 /opt/liferay \
# Remove this folder and map it later in docker-compose
&& rm -R /opt/liferay/deploy

# Configure permissions
RUN cd /opt \
&& chown -R liferay:liferay /opt/liferay \
&& ln -s /opt/liferay /opt/liferay \
&& ln -s /opt/liferay/tomcat-9.0.17 /opt/tomcat \
&& chown -R liferay:liferay /opt/liferay \
&& chmod +x /opt/tomcat/bin/*.sh

# Add env independent props
ENV LIFERAY_HOME=/opt/liferay
ENV CATALINA_HOME=/opt/tomcat
EXPOSE 8080 8443 11311 8000 9000

# Change user and run liferay
USER liferay
WORKDIR /opt/tomcat

ENTRYPOINT ["bin/catalina.sh", "run"]
