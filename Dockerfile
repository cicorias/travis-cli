FROM ruby:2.5-alpine
LABEL AUTHOR='Shawn Cicoria' EMAIL='github@cicoria.com'
LABEL REPO='https://github.com/cicorias/travis-cli-container'

ENV TRAVIS_VERSION 1.8.8

# Install travis cli and ruby dependencies
#   Also installs dev dependencies (build_deps) for compiling ruby-ffi
#   which are removed after install
RUN apk update \
    && apk upgrade \
    && apk add bash

RUN apk add --no-cache ruby ruby-io-console ruby-json git && \
    apk add --no-cache --virtual build_deps \
    build-base ruby-dev libc-dev libffi-dev linux-headers
RUN gem install travis -v ${TRAVIS_VERSION} --no-rdoc --no-ri
RUN gem install pry --no-rdoc --no-ri
RUN apk del build_deps

WORKDIR /root

# Default travis config directory: ~/.travis
VOLUME /root/.travis

# Mount your project to /data - essentially the git repo
VOLUME /data
WORKDIR /data

ENTRYPOINT ["travis"]
