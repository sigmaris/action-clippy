FROM rust:alpine3.12

ENV REVIEWDOG_VERSION=v0.10.2
ENV CLIPPY_FILTER_VERSION=v0.1.1

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git

RUN rustup component add clippy

RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

RUN wget -O /usr/local/bin/clippy-reviewdog-filter -q \
  https://github.com/qnighy/clippy-reviewdog-filter/releases/download/${CLIPPY_FILTER_VERSION}/clippy-reviewdog-filter-x86_64-unknown-linux-musl \
  && chmod +x /usr/local/bin/clippy-reviewdog-filter

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
