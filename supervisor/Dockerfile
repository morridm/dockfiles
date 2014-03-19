FROM elex/centos:latest
RUN yum install -q -y python-pip openssh-server openssh-clients passwd
RUN bash -c 'echo "net.ipv4.tcp_fin_timeout = 30\nnet.ipv4.tcp_keepalive_time = 300\\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_synack_retries = 2\nnet.ipv4.tcp_syn_retries = 3\nnet.ipv4.tcp_tw_reuse = 1\nnet.ipv4.tcp_tw_recycle = 1\nnet.ipv4.tcp_max_syn_backlog = 4096\nnet.ipv4.ip_conntrack_max = 6553600\nnet.ipv4.netfilter.ip_conntrack_max = 6553600\n" >> /etc/sysctl.conf'
# install supervisord
RUN /usr/bin/python /usr/bin/pip install supervisor
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd
ADD supervisord.conf /etc/
EXPOSE 22
CMD ["supervisord", "-n"]
