# Closest to RHEL 6
FROM centos:centos6

# Me :)
LABEL authors="Yann39"

# Get parameter from docker compose, this is the configuration file used for installation
ARG CONF_FILE

# Install dependencies
RUN yum -y update && yum -y install \
    wget \
    java-1.8.0-openjdk.x86_64 \
    libreoffice.x86_64 \
    ImageMagick.x86_64 \
    ImageMagick-devel.x86_64

# Clean downloaded packages
RUN rm -rf /var/lib/apt/lists/*

# Download Maven 3
RUN wget -q http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz -O /tmp/apache-maven-3.5.2-bin.tar.gz
RUN tar xzf /tmp/apache-maven-3.5.2-bin.tar.gz -C /usr/share

# Set Maven and JPDA environment variables
ENV MAVEN_HOME=/usr/share/apache-maven-3.5.2
ENV PATH=$PATH:$MAVEN_HOME/bin
ENV JPDA_ADDRESS="8000"
ENV JPDA_TRANSPORT="dt_socket"

# Add JRebel support
COPY jrebel/jrebel.jar /usr/local/jrebel/jrebel.jar
COPY jrebel/libjrebel64.so /usr/local/jrebel/libjrebel64.so
ENV JAVA_OPTS="-agentpath:/usr/local/jrebel/libjrebel64.so -Drebel.remoting_plugin=true"

# Download Digital Experience Manager 7.1.2.1
RUN wget -q https://www.jahia.com/downloads/jahia/digitalexperiencemanager7.1.2/DigitalExperienceManager-EnterpriseDistribution-7.1.2.1-r54750.3813.jar -O /tmp/DigitalExperienceManager.jar

# Download MySQL connector
RUN wget -q http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.35/mysql-connector-java-5.1.35.jar -O /usr/lib/mysql-connector-java-5.1.35.jar

# Copy local files to container so they can be executed later on container run
COPY jahia-7.1.2.1/install.sh /tmp/install.sh
COPY jahia-7.1.2.1/start.sh /tmp/start.sh
COPY jahia-7.1.2.1/wait.sh /tmp/wait.sh
COPY jahia-7.1.2.1/$CONF_FILE /tmp/configuration.xml

# Get modules to be deployed on Jahia installation, example
RUN mkdir /tmp/jahia_modules
RUN wget -q https://store.jahia.com/cms/mavenproxy/private-app-store/org/jahia/modules/bootstrap3-core/3.4.1/bootstrap3-core-3.4.1.jar -O /tmp/jahia_modules/bootstrap3-core-3.4.1.jar