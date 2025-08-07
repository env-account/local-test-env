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
        pip install --upgrade wheel
# RUN cd /home/python && pip install -r requirement.txt
RUN pip install Babel==0.9.6
RUN pip install backports.ssl-match-hostname==3.4.0.2
RUN pip install certifi==2021.10.8
RUN pip install cffi==1.15.1
RUN pip install chardet==4.0.0
RUN pip install Cheetah==2.4.4
RUN pip install CherryPy==3.2.2
RUN pip install configobj==4.7.2
RUN pip install cos-python-sdk-v5==1.7.5
RUN yum install -y gcc
RUN pip install crcmod==1.7
RUN pip install cryptography==3.3.2
RUN pip install DBUtils==1.3
RUN pip install decorator==3.4.0
RUN pip install dicttoxml==1.7.4
RUN pip install enum34==1.0.4
RUN pip install fluent-logger==0.9.6
RUN pip install futures==3.1.1
RUN pip install hashids==1.2.0
RUN pip install idna==2.10
RUN pip install iniparse==0.4
RUN pip install ipaddress==1.0.16
RUN pip install ipip-ipdb==1.6.1
RUN pip install Jinja2==2.7.2
RUN pip install jsonpatch==1.2
RUN pip install jsonpointer==1.9
RUN pip install jsonschema==2.5.1
RUN pip install jwcrypto==0.2.1
RUN pip install kitchen==1.1.1
RUN pip install langtable==0.0.44
RUN pip install Markdown==2.4.1
RUN pip install MarkupSafe==0.11
RUN pip install meld3==0.6.10
RUN pip install msgpack==0.6.2
RUN yum install -y python-devel
RUN pip install MySQL-python==1.2.5
RUN pip install oauthlib==2.0.1
RUN pip install Pillow==2.0.0
RUN pip install pipdeptree==2.0.0
RUN pip install ply==3.4
RUN pip install prettytable==0.7.2
RUN pip install protobuf==2.5.0
RUN pip install pyasn1==0.1.9
RUN pip install pycparser==2.14
RUN pip install pycrypto==2.6.1
RUN pip install pycryptodome==3.12.0
RUN pip install pycurl==7.19.0
RUN pip install Pygments==1.4
RUN pip install pygpgme==0.3
RUN pip install pyliblzma==0.5.3
RUN pip install pypinyin==0.44.0
RUN pip install python-augeas==0.5.0
RUN pip install pyudev==0.15
RUN pip install pyxattr==0.5.1
RUN pip install PyYAML==3.10
RUN pip install redis==2.10.6
RUN pip install repoze.lru==0.4
RUN pip install requests==2.26.0
RUN pip install requests-http-signature==0.2.0
RUN pip install six==1.9.0
RUN pip install supervisor==3.4.0
RUN pip install typing==3.10.0.0
RUN pip install urlgrabber==3.10
RUN pip install urllib3==1.26.7
RUN pip install virtualenv==16.7.9
RUN pip install web.py==0.37
RUN pip install websocket-client==0.56.0
RUN pip install yum-metadata-parser==1.1.4
RUN pip install zhon==1.1.5
# RUN pip install schedutils==0.4
# 2.269 ERROR: Could not find a version that satisfies the requirement schedutils==0.4 (from versions: none)
# 2.269 ERROR: No matching distribution found for schedutils==0.4
# RUN pip install python-dmidecode==3.10.13
# 2.224 ERROR: Could not find a version that satisfies the requirement python-dmidecode==3.10.13 (from versions: none)
# 2.224 ERROR: No matching distribution found for python-dmidecode==3.10.13
RUN mkdir -p /home/software
ADD ./libevent-2.0.22-stable.tar /home/software
RUN yum install -y make
RUN cd /home/software && cd libevent-2.0.22-stable && CFLAGS=-fPIC ./configure --prefix=/home/software/libevent && make && make install
ADD ./python-libevent-0.9.2.tar /home/software
RUN cd /home/software && cd python-libevent-0.9.2 && \
        sed -i "s/LIBEVENT_ROOT = os.environ.get('LIBEVENT_ROOT')/LIBEVENT_ROOT = '\/home\/software\/libevent'/g" setup.py && \
        sed -i "s/os.path.join(LIBEVENT_ROOT, '.libs', 'libevent.a')/os.path.join(LIBEVENT_ROOT, 'lib', 'libevent.a')/g" setup.py && \
        sed -i "s/os.path.join(LIBEVENT_ROOT, '.libs', 'libevent_pthreads.a')/os.path.join(LIBEVENT_ROOT, 'lib', 'libevent_pthreads.a')/g" setup.py && \
        cat setup.py && \
        python setup.py build && \
        python setup.py install