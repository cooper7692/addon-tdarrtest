ARG BUILD_FROM
FROM ${BUILD_FROM}

LABEL maintainer="Cooper7692"

# Install required tools for transcoding
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    nodejs \
    npm \
    jq \
    bash \
    ffmpeg \
    handbrake-cli \
    mkvtoolnix \
    && mkdir -p /tdarr \
    && rm -rf /var/lib/apt/lists/*

# Download and install the Tdarr Updater binary
RUN curl -L https://storage.tdarr.io/versions/2.17.01/linux_x64/Tdarr_Updater.zip -o /tmp/Tdarr_Updater.zip \
 && unzip /tmp/Tdarr_Updater.zip -d /tdarr \
 && chmod +x /tdarr/Tdarr_Updater \
 && rm /tmp/Tdarr_Updater.zip

# Copy s6-overlay services and static Tdarr directory
COPY rootfs /
COPY tdarr /tdarr
RUN chmod+x /rootfs/etc/services.d/tdarr/run
