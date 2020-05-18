#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  wget -O tserver.zip "https://terraria.org/system/dedicated_servers/archives/000/000/036/original/terraria-server-1402.zip" && \
  unzip tserver.zip && \
  rm tserver.zip && \
  chmod +x '/1402/Linux/TerrariaServer.bin.x86_64' && \
  rm -rf /1402/Mac && \
  rm -rf /1402/Windows
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

COPY runthis.sh       /
COPY serverconfig.txt /

# Define default command.
CMD ["bash"]
