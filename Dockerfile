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
# RUN pip install python-libevent==0.9.2
# 3.938 Collecting python-libevent==0.9.2
# 5.898   Downloading python-libevent-0.9.2.tar.gz (33 kB)
# 6.517     ERROR: Command errored out with exit status 1:
# 6.517      command: /usr/bin/python -c 'import sys, setuptools, tokenize; sys.argv[0] = '"'"'/tmp/pip-install-KPe0mm/python-libevent/setup.py'"'"'; __file__='"'"'/tmp/pip-install-KPe0mm/python-libevent/setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' egg_info --egg-base /tmp/pip-pip-egg-info-BcLYzP
# 6.517          cwd: /tmp/pip-install-KPe0mm/python-libevent/
# 6.517     Complete output (5 lines):
# 6.517     Traceback (most recent call last):
# 6.517       File "<string>", line 1, in <module>
# 6.517       File "/tmp/pip-install-KPe0mm/python-libevent/setup.py", line 35, in <module>
# 6.517         raise TypeError('Please set the environment variable LIBEVENT_ROOT ' \
# 6.517     TypeError: Please set the environment variable LIBEVENT_ROOT to the path of your libevent root directory and make sure to pass "--with-pic" to configure when building it
# 6.517     ----------------------------------------
# 6.518 ERROR: Command errored out with exit status 1: python setup.py egg_info Check the logs for full command output.
# RUN pip install python-linux-procfs==0.4.9
# 2.160 ERROR: Could not find a version that satisfies the requirement python-linux-procfs==0.4.9 (from versions: none)
# 2.161 ERROR: No matching distribution found for python-linux-procfs==0.4.9
# RUN pip install pygobject==3.27.0
# 8.586   Package glib-2.0 was not found in the pkg-config search path.
# 8.586   Perhaps you should add the directory containing `glib-2.0.pc'
# 8.586   to the PKG_CONFIG_PATH environment variable
# 8.586   No package 'glib-2.0' found
# 8.586   Command '['pkg-config', '--print-errors', '--exists', u'glib-2.0 >= 2.38.0']' returned non-zero exit status 1
# 8.586   ----------------------------------------
# 8.586   ERROR: Failed building wheel for pygobject
# 8.586   Running setup.py clean for pygobject
# 8.845   Building wheel for pycairo (setup.py): started
# 9.126   Building wheel for pycairo (setup.py): finished with status 'error'
# 9.126   ERROR: Command errored out with exit status 1:
# 9.126    command: /usr/bin/python -u -c 'import sys, setuptools, tokenize; sys.argv[0] = '"'"'/tmp/pip-install-DdtHZf/pycairo/setup.py'"'"'; __file__='"'"'/tmp/pip-install-DdtHZf/pycairo/setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' bdist_wheel -d /tmp/pip-wheel-tnFgwA
# RUN pip install cloud-init==17.1
# 2.231 ERROR: Could not find a version that satisfies the requirement cloud-init==17.1 (from versions: none)
# 2.231 ERROR: No matching distribution found for cloud-init==17.1