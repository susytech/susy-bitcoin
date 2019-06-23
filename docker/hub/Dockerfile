FROM ubuntu:xenial
LABEL MAINTAINER="Susy Technologies <devops-team@susy.io>"

# install tools and dependencies
RUN apt update && apt install -y --no-install-recommends openssl

# show backtraces
ENV RUST_BACKTRACE 1

# cleanup Docker image
RUN apt autoremove -y \
  && apt clean -y \
  && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN groupadd -g 1000 susybtc-ubuntu \
  && useradd -m -u 1000 -g susybtc-ubuntu -s /bin/sh susybtc-ubuntu

WORKDIR /home/susybtc-ubuntu

# add susy-sophon to docker image
COPY artifacts/$CARGO_TARGET/susybtc /bin/susybtc-ubuntu

COPY scripts/docker/hub/check_sync.sh /check_sync.sh

# switch to user susy here
USER susybtc-ubuntu

# setup ENTRYPOINT
EXPOSE 8333 18333 8332 18332
ENTRYPOINT ["/bin/susybtc-ubuntu"]
