
FROM ubuntu:20.10

WORKDIR /rocs

# Install git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/KSam-J/rocs-feather.git

RUN cd rocs-feather && \
    ./linux_tools.sh handy

CMD ["bash"]
