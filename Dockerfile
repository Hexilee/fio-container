FROM ljishen/fio:latest
MAINTAINER Hexilee <i@hexilee.me>

RUN mkdir /test
COPY job.fio /job.fio
RUN chmod 600 /job.fio

CMD ["/job.fio"]
