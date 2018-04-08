FROM centos:7

MAINTAINER Wang Lilong "wanglilong007@gmail.com"

ENV VERSION=6.1.0

RUN set -x \  
	&& yum install -y epel-release \
	&& yum install -y python-pip dnsmasq \
	&& buildDeps='curl gcc g++ make python-devel libffi-dev' \
	&& yum install -y $buildDeps \
    && curl -fSL https://github.com/openstack/ironic-inspector/archive/${VERSION}.tar.gz -o ironic-inspector-${VERSION}.tar.gz \
    && tar xf ironic-inspector-${VERSION}.tar.gz \
    && cd ironic-inspector-${VERSION} \
    && pip install -r requirements.txt \
    && PBR_VERSION=${VERSION}  pip install . \
    && mkdir /etc/ironic-inspector \
    && cp rootwrap.conf /etc/ironic-inspector \
    && pip install PyMySQL pymemcache\
    && cd - \
    && rm -rf ironic-inspector-${VERSION}* \
    && yum clean all
COPY inspector.conf /etc/ironic-inspector/inspector.conf
