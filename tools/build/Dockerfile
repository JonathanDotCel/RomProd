# Dockerfile for unirom/build

FROM ubuntu:20.04

# The tzdata package isn't docker-friendly, and something pulls it.
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Etc/GMT

RUN apt update

# Utility packages
RUN apt install -y git
RUN apt install -y make

# Compilers & base libraries
RUN apt install -y g++-mipsel-linux-gnu

# C# cruft
RUN apt install -y mono-runtime

RUN mkdir /project
WORKDIR /project
