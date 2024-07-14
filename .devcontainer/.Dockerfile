FROM ubuntu:20.04

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
