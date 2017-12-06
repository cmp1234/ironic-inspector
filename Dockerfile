FROM python:2.7-slim-jessie

MAINTAINER Wang Lilong "wanglilong007@gmail.com"

ENV VERSION=6.1.0

RUN set -x \  
    && apt-get update \
	&& buildDeps='curl gcc g++ make libffi-dev' \
	&& apt-get install -y --no-install-recommends $buildDeps \
    && curl -fSL https://github.com/openstack/ironic-inspector/archive/${VERSION}.tar.gz -o ironic-inspector-${VERSION}.tar.gz \
    && tar xf ironic-inspector-${VERSION}.tar.gz \
    && cd ironic-inspector-${VERSION} \
    && pip install -r requirements.txt \
    && PBR_VERSION=${VERSION}  pip install . \
    && mkdir /etc/ironic-inspector
    && cp example.conf /etc/ironic-inspector/inspector.conf \
    && cp rootwrap.conf /etc/ironic-inspector \
    && pip install PyMySQL \
    && cd - \
    && rm -rf ironic-inspector-${VERSION}* \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /var/lib/apt/lists/*
