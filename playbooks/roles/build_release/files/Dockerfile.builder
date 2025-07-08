ARG BUILD_IMAGE
FROM $BUILD_IMAGE

ARG ERLANG_VERSION
ARG ELIXIR_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get install -y curl git build-essential autoconf automake libssl-dev libncurses5-dev libwxgtk3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev unzip locales && \
    locale-gen C.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v0.14.0

ENV PATH="/root/.asdf/bin:/root/.asdf/shims:$PATH"

RUN bash -c 'source /root/.asdf/asdf.sh && \
    asdf plugin add erlang || true && \
    asdf plugin add elixir || true && \
    asdf install erlang $ERLANG_VERSION && \
    asdf global erlang $ERLANG_VERSION && \
    asdf install elixir $ELIXIR_VERSION && \
    asdf global elixir $ELIXIR_VERSION && \
    mix local.hex --force && \
    mix local.rebar --force'

# ENTRYPOINT ["/bin/bash"]
