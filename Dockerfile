FROM openresty/openresty:1.15.8.1-0-bionic

RUN apt-get -q -y update \
 && apt-get -q -y install perl libyaml-dev libyaml-perl \
 && apt-get -q -y install git wget

# cpan
RUN wget http://xrl.us/cpanm
RUN perl cpanm --notest Test::Nginx

RUN ln -s /usr/local/openresty/luajit/bin/luajit /usr/local/openresty/luajit/bin/lua
ENV PATH $PATH:/opt/openresty/nginx/sbin:/usr/local/openresty/luajit/bin

# luarocks
RUN luarocks install lyaml YAML_LIBDIR=/usr/lib/x86_64-linux-gnu/
RUN luarocks install etlua
RUN luarocks install luacheck

ADD . /code/

WORKDIR /code
