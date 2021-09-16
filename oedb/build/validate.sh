#!/bin/bash
## Validate if mandatory properties are set

VALIDATE_SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
ARTIFACTS_DIR=${VALIDATE_SCRIPT_PATH}/artifacts

if [ -z ${NEW_DB_DOCKER_IMAGE_NAME} ]; then
	echo "NEW_DB_DOCKER_IMAGE_NAME is not set"
	exit 1
fi

if [ -z ${NEW_DB_DOCKER_IMAGE_TAG} ]; then
	echo "NEW_DB_DOCKER_IMAGE_TAG is not set"
	exit 1
fi

if [ -z ${DB_NAME} ]; then
	echo "DB_NAME is not set"
	exit 1
fi

if [ -z ${DB_DOCKER_IMAGE_NAME} ]; then
	echo "DB_DOCKER_IMAGE_NAME is not set"
	exit 1
fi

if [ -z ${DB_DOCKER_IMAGE_TAG} ]; then
	echo "DB_DOCKER_IMAGE_TAG is not set"
	exit 1
fi

if [ -z ${JDK_DOCKER_IMAGE_NAME} ]; then
	echo "JDK_DOCKER_IMAGE_NAME is not set"
	exit 1
fi

if [ -z ${JDK_DOCKER_IMAGE_TAG} ]; then
	echo "JDK_DOCKER_IMAGE_TAG is not set"
	exit 1
fi

if [ -z ${JDK_DOCKER_IMAGE_JAVA_LOCATION} ]; then
	echo "JDK_DOCKER_IMAGE_JAVA_LOCATION is not set"
	exit 1
fi

## Validate if license is provided
if [ ! -s ${SCRIPTPATH}/license/progress.cfg ]; then
	echo "License is not provided at ${SCRIPTPATH}/license"
	exit 1
fi

# Check if the progress.cgf has license for RDMS and 4GL
grep -iq "RDBMS" ${SCRIPTPATH}/license/progress.cfg
license_RDBMS=$?
grep -iq "4GL Development System" ${SCRIPTPATH}/license/progress.cfg
license_4gl=$?
if [[ ${license_RDBMS} != 0 || ${license_4gl} != 0 ]]; then
	echo "progress.cfg is not licensed for OE RDBMS or 4GL Development System"
	exit 1
fi

## Validation for all modes
case "${DB_CREATE_METHOD}" in
	customDB)
	    st_file_count=$(ls -1 ${ARTIFACTS_DIR}/*.st 2>/dev/null | wc -l)
	    d_file_count=$(ls -1 ${ARTIFACTS_DIR}/*.d 2>/dev/null | wc -l)
	    df_file_count=$(ls -1 ${ARTIFACTS_DIR}/*.df 2>/dev/null | wc -l)

	    if [[ ${d_file_count} -gt 0 ]] && [[ ${df_file_count} -eq 0 ]]; then
	    	echo "Please provide a schema(.df) for the data(.d) file"
	    	exit 1
	    fi

	    if [[ ${st_file_count} -eq 1 ]] && [[ ! -f ${ARTIFACTS_DIR}/${DB_NAME}.st ]]; then
	    	echo "Structure(.st) file name should ${DB_NAME}.st"
	    	exit 1
	    fi

	    if [[ ${st_file_count} -gt 1 ]]; then
	    	echo "Multiple structure(.st) files are not supported."
	    	exit 1
	    fi
		;;
	backupDB)
        BACKUP_FILE=${ARTIFACTS_DIR}/${DB_NAME}.bck
	    # Validate if Backup File is present
	    if [ ! -f ${BACKUP_FILE} ]; then
	    	echo "Backup File not found: '${BACKUP_FILE}'"
	    	exit 1
	    fi
		;;
	sampleDB)
		if [ -z ${SAMPLE_DB_NAME} ]; then
	    	echo "DB_CREATE_METHOD is sampleDB and SAMPLE_DB_NAME is not set"
	    	exit 1
	    fi
		;;
	externalDB)
		if [ -z ${EXTERNAL_DATABASE_PATH} ]; then
            echo "External database path is not set";
            exit 1;
        else
            if [ ! -d ${EXTERNAL_DATABASE_PATH} ]; then echo "Provided external database path does not exit"; exit 1; fi
            if [ -f ${EXTERNAL_DATABASE_PATH}/${DB_NAME}.lk ]; then echo "Provided external database path contains ${DB_NAME}.lk. It is required to shutdown the database before it can be used inside container"; exit 1; fi
            if [ ! -f ${EXTERNAL_DATABASE_PATH}/${DB_NAME}.db ]; then echo "Provided external database path does not have a database file"; exit 1; fi
        fi
		;;
	*)
        echo "Invalid DB_CREATE_METHOD. Must be one of ['customDB','backupDB','sampleDB','externalDB']"
		exit 1
	    ;;
esac

