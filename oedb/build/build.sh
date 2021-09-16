#!/bin/bash
# Builds an new OpenEdge Database image

SCRIPTPATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

ARTIFACTS_DIR=${SCRIPTPATH}/artifacts

# Read config properties file
CONFIG_PROPS_FILE="${SCRIPTPATH}/config.properties"
source ${CONFIG_PROPS_FILE}

# validate properties and license
source ${SCRIPTPATH}/validate.sh

unmount() {
  mountpoint ${ARTIFACTS_DIR} > /dev/null
  if [ $? == 0 ]; then umount ${ARTIFACTS_DIR}; fi
}

if [ ! -z ${SAMPLE_DB_NAME} ]; then 
    SAMPLE_DB_NAME_ARG="--build-arg SAMPLE_DB_NAME=${SAMPLE_DB_NAME}"
fi

# Load the database image.
DB_IMAGE_FILE="${SCRIPTPATH}/../PROGRESS_OE_DATABASE_CONTAINER_IMAGE_12.3.0_LNX_64.tar.gz"
if [ "x${DB_DOCKER_IMAGE_TAG}" == "x12.3.0_adv-ent" ]; then
  DB_IMAGE_FILE="${SCRIPTPATH}/../PROGRESS_OE_ADVANCED_DATABASE_CONTAINER_IMAGE_12.3.0_LNX_64.tar.gz"
fi
if [[ -f ${DB_IMAGE_FILE} ]]; then
  echo "Loading the openedge database image ..."
  docker load -i ${DB_IMAGE_FILE}
fi

# Mount external database to ${ARTIFACTS_DIR} folder
# to make it available for docker to build
if [ "${DB_CREATE_METHOD}" == "externalDB" ]; then
  if [ -d ${EXTERNAL_DATABASE_PATH} ]; then
    unmount 
    mount --bind ${EXTERNAL_DATABASE_PATH} ${ARTIFACTS_DIR}
  fi
fi

# Build the new DB docker image
docker build \
    -t ${NEW_DB_DOCKER_IMAGE_NAME}:${NEW_DB_DOCKER_IMAGE_TAG} \
    ${SAMPLE_DB_NAME_ARG} \
    --build-arg DB_CREATE_METHOD=${DB_CREATE_METHOD} \
    --build-arg DB_NAME=${DB_NAME} \
    --build-arg DB_DOCKER_IMAGE_NAME=${DB_DOCKER_IMAGE_NAME} \
    --build-arg DB_DOCKER_IMAGE_TAG=${DB_DOCKER_IMAGE_TAG} \
    --build-arg JDK_DOCKER_IMAGE_NAME=${JDK_DOCKER_IMAGE_NAME} \
    --build-arg JDK_DOCKER_IMAGE_TAG=${JDK_DOCKER_IMAGE_TAG} \
    --build-arg JDK_DOCKER_IMAGE_JAVA_LOCATION=${JDK_DOCKER_IMAGE_JAVA_LOCATION} \
    --no-cache \
    ${SCRIPTPATH}

DOCKER_BUILD_EXIT_CODE=$?

# Remove the mount point
if [ "${DB_CREATE_METHOD}" == "externalDB" ]; then
  unmount
fi

exit ${DOCKER_BUILD_EXIT_CODE}
