FROM fireballdwf/alpine-payara-mysqljdbc:latest

# Maintainer
# ----------
MAINTAINER David Filiatrault <david.filiatrault+github@gmail.com>

ENV APPDOMAIN payaradomain 

# Following creates directory due to https://github.com/payara/Payara/issues/701
ENV ENDORSED=$GLASSFISH_INSTALL_DIR/lib/endorsed
user payara
RUN mkdir $ENDORSED

# Files going to the endorsed directory per https://github.com/remmelt/log-collector#glassfish-4-configuration 
RUN wget -P $ENDORSED http://central.maven.org/maven2/biz/paluch/logging/logstash-gelf/1.8.1/logstash-gelf-1.8.1.jar 
# TODO: Verify keys per http://logging.paluch.biz/download.html
RUN wget -P $ENDORSED http://central.maven.org/maven2/com/googlecode/json-simple/json-simple/1.1.1/json-simple-1.1.1.jar
COPY logging.properties $GLASSFISH_INSTALL_DIR/domains/$APPDOMAIN/config/
COPY logging.properties $GLASSFISH_INSTALL_DIR/domains/$APPDOMAIN/config/default-logging.properties
