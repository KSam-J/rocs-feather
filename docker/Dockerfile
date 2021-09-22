
FROM ubuntu:20.10

WORKDIR /rocs_feather

ENV TZ=US/Arizona
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Build context should be: rocs_feather base directory
COPY . .

RUN ./linux_tools.sh handy
RUN ./setup_all.sh

CMD ["bash"]
