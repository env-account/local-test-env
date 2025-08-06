FROM ccr.ccs.tencentyun.com/qcloud/centos:latest
RUN rm /etc/yum.repos.d/CentOS-Epel.repo
RUN --mount=type=bind,source=Centos-7.repo,target=Centos-7.repo \
    cp Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum install -y epel-release && \
        yum install -y protobuf-devel && \
        yum install -y lua-devel && \
        yum install -y libevent-devel && \
        yum install -y hiredis-devel && \
        yum install -y log4cplus-devel && \
        yum install -y boost-devel && \
        yum install -y jsoncpp-devel && \
        yum install -y libuuid-devel && \
        yum install -y openssl-devel && \
        yum install -y libcurl-devel && \
        yum install -y mariadb-devel
RUN mkdir -p /home/python
ADD ./requirement.txt /home/python
RUN cd /home/python && \
        curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && \
        python get-pip.py && \
        pip install --upgrade pip && \
        pip install --upgrade setuptools==44.1.1 && \
        pip install --upgrade wheel && \
        pip install -r requirement.txt