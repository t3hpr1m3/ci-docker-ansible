FROM docker:19.03-git

ARG install_python_versions="2.7.18 3.6.11 3.7.7 3.8.3"
ARG default_python_version="3.7.7"
ARG pyenv_root="/.pyenv"

ENV PYENV_ROOT $pyenv_root

RUN apk add --no-cache \
		bash \
		ca-certificates \
		curl && \
	apk add --no-cache --virtual .fetch-deps \
		curl \
		gnupg \
		tar \
		xz && \
	curl https://pyenv.run | bash && \
	apk del --no-network .fetch-deps && \
	apk add --no-cache --virtual .build-deps \
		bzip2-dev \
		coreutils \
		gcc \
		gdbm-dev \
		libc-dev \
		libffi-dev \
		libnsl-dev \
		libtirpc-dev \
		linux-headers \
		make \
		ncurses-dev \
		openssl-dev \
		patch \
		pax-utils \
		readline-dev \
		sqlite-dev \
		tcl-dev \
		tk \
		tk-dev \
		util-linux-dev \
		xz-dev \
		zlib-dev && \
	for v in $install_python_versions; do PATH=$PYENV_ROOT/bin:$PATH MAKEOPTS="-j$(nproc)" pyenv install $v; done && \
	PATH=$PYENV_ROOT/bin:$PATH pyenv global $default_python_version && \
	apk del --no-network .build-deps && \
	echo -e '[ -n "$BASHRC_SOURCED" ] && return\n\
export BASHRC_SOURCED=1\n\
export PATH=$PYENV_ROOT/bin:$PATH\n\
eval "$(pyenv init -)"\n\
eval "$(pyenv virtualenv-init -)"\n' >> /root/.bashrc

CMD ["/bin/bash"]
