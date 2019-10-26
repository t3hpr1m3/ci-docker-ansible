FROM docker:git

RUN apk update && \
	apk add --no-cache \
		docker \
		python3-dev \
		py3-pip \
		gcc \
		git \
		curl \
		build-base \
		autoconf \
		automake \
		py3-cryptography \
		linux-headers \
		musl-dev \
		libffi-dev \
		openssl-dev \
		openssh &&
	pip3 install ansible molecule docker
