FROM elex/supervisor:latest
RUN yum install gcc git -y -q
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
RUN cd /opt/ && git clone https://github.com/coreos/etcd && cd etcd && ./build
EXPOSE 4001 7001
RUN echo -e [program:etcd]\\ncommand = /opt/etcd/bin/etcd\\n >> /etc/supervisord.conf

