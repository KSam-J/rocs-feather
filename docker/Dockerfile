
FROM ubuntu:22.04

WORKDIR /rocs_feather

ENV TZ=US/Arizona
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Define username and temporary uid and gid
ENV USER=rocs USER_ID=1000 USER_GID=1000

RUN apt-get update && \
    apt-get install -y sudo openssl apt-utils && \
    rm -rf /var/lib/apt/lists/*

# now creating user, change password to 'feather'
RUN groupadd --gid "${USER_GID}" "${USER}" && \
    useradd \
      --uid ${USER_ID} \
      --gid ${USER_GID} \
      --create-home \
      --shell /bin/bash\
      --password $(openssl passwd -1 feather) \
      ${USER} \
    && chmod 0755 /home/rocs

#setup locale
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
     apt-get install -y locales && \
     dpkg-reconfigure locales --frontend noninteractive && \
     locale-gen "en_US.UTF-8" && \
     update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
     rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Build context should be: rocs_feather base directory
COPY .. .

#RUN ./scripts/setup_all.sh

#CMD ["bash"]
COPY ../docker/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
