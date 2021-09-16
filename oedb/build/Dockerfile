# Arguments used for images
ARG DB_DOCKER_IMAGE_NAME=store/progresssoftware/oedb
ARG DB_DOCKER_IMAGE_TAG=12.3.0_ent

ARG JDK_DOCKER_IMAGE_NAME
ARG JDK_DOCKER_IMAGE_TAG

# Use JDK image as a staging image
FROM ${JDK_DOCKER_IMAGE_NAME}:${JDK_DOCKER_IMAGE_TAG} as builder-jdk

# Build the new OpenEdge Database image
FROM ${DB_DOCKER_IMAGE_NAME}:${DB_DOCKER_IMAGE_TAG}
USER pscadmin

# Copy license file
COPY --chown=pscadmin:pscadmin ./license/progress.cfg /psc/dlc/progress.cfg

# Copy JAVA
ARG JDK_DOCKER_IMAGE_JAVA_LOCATION
COPY --from=builder-jdk --chown=pscadmin:pscadmin ${JDK_DOCKER_IMAGE_JAVA_LOCATION} /usr/java

# Copy DB related artifacts
COPY --chown=pscadmin:pscadmin ./artifacts /deploy/artifacts/
COPY --chown=pscadmin:pscadmin ./abl-triggers /deploy/abl-triggers/
COPY --chown=pscadmin:pscadmin ./conf /deploy/scripts/config/
COPY --chown=pscadmin:pscadmin ./hook-script.sh /deploy/scripts/

# default values in case they are not provided in config.properties
ARG DB_CREATE_METHOD=sampleDB
ARG DB_NAME=user_db
ARG SAMPLE_DB_NAME=sports2020
ARG EXTERNAL_DATABASE_PATH=/usr/wrk

# set environment variables
ENV DB_CREATE_METHOD=${DB_CREATE_METHOD} \
    DB_NAME=${DB_NAME} \
    SAMPLE_DB_NAME=${SAMPLE_DB_NAME} \
    EXTERNAL_DATABASE_PATH=${EXTERNAL_DATABASE_PATH} \
    LD_LIBRARY_PATH=/usr/java/jre/lib/amd64/server/:/usr/java/jre/lib/amd64/:/usr/java/lib/server

# creates the relevant OpenEdge Database
RUN /deploy/scripts/create-db.sh
RUN /deploy/scripts/hook-script.sh

CMD ["/bin/sh", "-c", "/deploy/scripts/start-db-server.sh"]
