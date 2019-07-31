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
	iputils-ping \
	python-pip \
	python-pymongo \
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

RUN pip install cassandra-driver cqlsh
RUN wget https://releases.hashicorp.com/vault/1.1.3/vault_1.1.3_linux_amd64.zip -O - | gunzip - > vault && chmod +x vault
RUN wget http://ftp.unicamp.br/pub/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz -O - | tar zxv -C /

ENV CQLSH_NO_BUNDLED="true"
