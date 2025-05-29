FROM ruby:3.2-slim

ARG UID=1000
ARG GID=1000

# Install only what's needed to build and run github-linguist
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libgit2-dev \
    libicu-dev \
    pkg-config \
 && gem install --no-document github-linguist \
 && apt-get purge -y --auto-remove \
    build-essential cmake git \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create non-root user using build args
RUN addgroup --gid ${GID} linguist && \
    adduser --uid ${UID} --gid ${GID} --disabled-password --gecos "" linguist

USER linguist
WORKDIR /repo

ENTRYPOINT ["github-linguist"]
