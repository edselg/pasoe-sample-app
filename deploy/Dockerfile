FROM alpine:3.8

# Root location
ARG ROOT_FOLDER=/deploy-staging

ARG MANIFEST_VERSION=1.0

# Copy archive file
COPY ./output/package-output ${ROOT_FOLDER}/artifacts/

# Create "META-INF/MANIFEST.MF" file
RUN mkdir ${ROOT_FOLDER}/META-INF
RUN echo "Manifest-Version: ${MANIFEST_VERSION}" > ${ROOT_FOLDER}/META-INF/MANIFEST.MF
RUN echo "Date-Timestamp: `date +'%Y-%m-%dT%H:%M:%S%z'`" >> ${ROOT_FOLDER}/META-INF/MANIFEST.MF

# Set working directory
WORKDIR ${ROOT_FOLDER}
