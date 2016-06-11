FROM fireballdwf/alpine-payara-mysqljdbc:latest

# Maintainer
# ----------
MAINTAINER David Filiatrault <david.filiatrault+github@gmail.com>

# Following creates directory due to https://github.com/payara/Payara/issues/701
ENV ENDORSED=$GLASSFISH_INSTALL_DIR/lib/endorsed
user payara
# Files going to the endorsed directory per https://github.com/remmelt/log-collector#glassfish-4-configuration 
RUN mkdir $ENDORSED && \
    wget -P $ENDORSED http://search.maven.org/remotecontent?filepath=biz/paluch/logging/logstash-gelf/1.10.0/logstash-gelf-1.10.0.jar && \
    wget -P $ENDORSED https://repo1.maven.org/maven2/com/googlecode/json-simple/json-simple/1.1.1/json-simple-1.1.1.jar
# COPY logstash-gelf-1.9.0-SNAPSHOT.jar $ENDORSED
# TODO: Verify keys per http://logging.paluch.biz/download.html
COPY logging.properties $GLASSFISH_INSTALL_DIR/domains/$APPDOMAIN/config/
# Following not needed per https://github.com/payara/Payara/issues/713#issuecomment-199800102
# COPY logging.properties $GLASSFISH_INSTALL_DIR/domains/$APPDOMAIN/config/default-logging.properties
