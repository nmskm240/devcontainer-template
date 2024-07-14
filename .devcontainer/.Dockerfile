FROM ubuntu:20.04

ARG USER_NAME=developer
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y \
    git \
    tzdata \
    # plantuml用
    default-jre \
    graphviz \
    # vscode tunnel用
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz \
    && tar -xf vscode_cli.tar.gz \
    && mv code /usr/local/bin/

RUN groupadd -r --gid $GROUP_ID $USER_NAME && \
    useradd -m -r --uid $USER_ID --gid $GROUP_ID $USER_NAME

USER $USER_NAME
