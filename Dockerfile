FROM 3scale/openresty

RUN apt-get -q -y update \
 && apt-get -q -y install perl libyaml-dev libyaml-perl \
 && apt-get -q -y install git

# cpan
RUN wget http://xrl.us/cpanm
RUN perl cpanm --notest Test::Nginx

# lua
RUN luarocks install lyaml YAML_LIBDIR=/usr/lib/x86_64-linux-gnu/
RUN luarocks install etlua

ENV PATH $PATH:/opt/openresty/nginx/sbin

ADD . /code/

WORKDIR /code
