FROM ruby:3.2-slim

RUN apt-get update && apt-get install -y \
  git \
  build-essential \
  cmake \
  libgit2-dev \
  libicu-dev \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

# Install linguist gem (works as CLI here)
RUN gem install github-linguist

WORKDIR /repo

ENTRYPOINT ["github-linguist"]
