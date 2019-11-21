FROM centos:7
ARG ROOT_PASSWORD
COPY ./script.sh /
RUN sh script.sh
