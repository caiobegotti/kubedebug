# build this with: docker build -t caiobegotti/kubedebug .
#
# to run this container: kubectl run kubedebug --rm -it --image=caiobegotti/kubedebug:latest
#
# to debug mongo connections: mongo mongodb://mongodb:27017/?replicaSet=MainRepSet --authenticationDatabase admin -u '' -p ''
#
# to debug vault clusters you will need VAULT_ADDR, VAULT_CAPATH and VAULT_TOKEN set
#
# to debug kafka producers and consumers look for scripts in /kafka*/bin/

FROM ubuntu:18.04

RUN apt-get update -y && \
	apt-get install -y \
	dnsutils \
	postgresql-client \
	iputils-ping \
	python-pip \
	python-pymongo \
	python-setuptools \
	mongodb-clients \
	mongo-tools \
	openjdk-11-jre-headless \
	curl \
	lynx \
	nmap \
	less \
	telnet \
	tcpdump \
	procps \
	strace \
	lsof \
	traceroute \
	jq \
	netcat-openbsd \
	net-tools \
	wget \
	kafkacat \
	python-confluent-kafka \
	vim \
	unzip

RUN pip install cassandra-driver cqlsh \
	&& mkdir -p /root/.cassandra/ \
	&& echo -e "[cql]\nversion=3.4.4" > /root/.cassandra/cqlshrc \
	&& rm -rf /root/.cache/*

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.10.0/protoc-3.10.0-linux-x86_64.zip -O protoc.zip \
	&& unzip protoc.zip -d /usr/local/ \
	&& rm -rf protoc.zip

# a lean grpc_cli installation is still pending

RUN wget https://releases.hashicorp.com/vault/1.1.3/vault_1.1.3_linux_amd64.zip -O - | gunzip - > vault && chmod +x vault
RUN wget http://ftp.unicamp.br/pub/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz -O - | tar zxv -C /

RUN wget https://github.com/pressly/goose/releases/download/v2.6.0/goose-linux64 -O /usr/local/bin/goose \
	&& chmod +x /usr/local/bin/goose

ENV CQLSH_NO_BUNDLED="true"
