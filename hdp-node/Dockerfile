FROM centos:centos6
MAINTAINER generydey@gmai.com
ENV TZ=Europe/Warsaw

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install wget openssh-server unzip ntp python-setuptools && \
    wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.0.3/ambari.repo -O /etc/yum.repos.d/ambari.repo && \
    yum -y --setopt=tsflags=nodocs install ambari-agent && \
    yum clean all

RUN echo "root:admingenerydey" | chpasswd && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/\(^hostname=\).*$/\1ambari/' /etc/ambari-agent/conf/ambari-agent.ini

RUN mkdir -p /var/lib/ambari-agent/resources/ && \
    wget -nv http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u112-linux-x64.tar.gz -P /var/lib/ambari-agent/resources/ && \
    mkdir -p /usr/jdk64/ && chmod a+x /usr/jdk64/ && \
    tar --no-same-owner -xf /var/lib/ambari-agent/resources/jdk-8u112-linux-x64.tar.gz -C /usr/jdk64/ && \
    wget -nv http://public-repo-1.hortonworks.com/ARTIFACTS/jce_policy-8.zip -P /var/lib/ambari-agent/resources/ && \
    unzip /var/lib/ambari-agent/resources/jce_policy-8.zip -d /usr/jdk64/jdk1.8.0_112/jre/lib/security/ && \
    rm -Rf /var/lib/ambari-agent/resources/*

RUN easy_install supervisor && mkdir /var/log/supervisor

ADD ./configs/supervisord.conf /etc/supervisord.conf
COPY ./configs/supervisord.d /etc/supervisord.d

EXPOSE 3000 8080 50070 50470 8020 8021 9000 50475 50075 50076 50010 50020 50030 50060 50090 8088 8090 8032 8033 8031 8651 8660 8661 8662 8663 10001 10000 9083 50111 51111 60000 60010 60020 60030 6188 61310 2888 3888 2181 3306 22 80

CMD supervisord
