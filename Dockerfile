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
        yum install -y mariadb-devel && \
        yum install -y gcc && \
        yum install -y python-devel && \
        yum install -y make
RUN mkdir -p /home/python
ADD ./requirement.txt /home/python
RUN cd /home/python && \
        curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && \
        python get-pip.py && \
        pip install --upgrade pip && \
        pip install --upgrade setuptools==44.1.1 && \
        pip install --upgrade wheel && \
        pip install -r requirement.txt
RUN mkdir -p /home/software
ADD ./libevent-2.0.22-stable.tar /home/software
RUN cd /home/software && cd libevent-2.0.22-stable && CFLAGS=-fPIC ./configure --prefix=/home/software/libevent && make && make install
ADD ./python-libevent-0.9.2.tar /home/software
RUN cd /home/software && cd python-libevent-0.9.2 && \
        sed -i "s/LIBEVENT_ROOT = os.environ.get('LIBEVENT_ROOT')/LIBEVENT_ROOT = '\/home\/software\/libevent'/g" setup.py && \
        sed -i "s/os.path.join(LIBEVENT_ROOT, '.libs', 'libevent.a')/os.path.join(LIBEVENT_ROOT, 'lib', 'libevent.a')/g" setup.py && \
        sed -i "s/os.path.join(LIBEVENT_ROOT, '.libs', 'libevent_pthreads.a')/os.path.join(LIBEVENT_ROOT, 'lib', 'libevent_pthreads.a')/g" setup.py && \
        cat setup.py && \
        python setup.py build && \
        python setup.py install