FROM ubuntu:22.04

####################
### apt packages ###
####################

# Set environment variable to prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# apt
RUN apt update && \ 
    apt install -y build-essential ripgrep fd-find openjdk-21-jdk unzip tmux git sudo vim wget software-properties-common

############
### User ###
############

# Create a non-root user
RUN useradd -m dev && \
    echo "dev:devpass" | chpasswd && \
    usermod -aG sudo dev && \
    chsh -s /bin/bash dev

# user-specific configs
WORKDIR /home/dev/
RUN mkdir .config/
RUN chown -R dev:dev .config/
# bashrc
COPY ./ext/.bashrc .
RUN chown dev:dev .bashrc
# tmux
RUN mkdir .config/tmux/
COPY ./ext/tmux.conf .config/tmux/tmux.conf

##############
### Neovim ###
##############

# prep directory
RUN mkdir -p /setup/neovim/
WORKDIR /setup/neovim/

# install neovim
RUN wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz && \
    tar -xvzf nvim-linux64.tar.gz && \
    mv nvim-linux64/ /usr/lib/ && \
    ln -s /usr/lib/nvim-linux64/bin/nvim /usr/bin/nvim

# neovim configs
WORKDIR /home/dev/
COPY ./src/ .config/nvim/
# packer
RUN mkdir -p .local/share/nvim/site/pack/packer/start
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim .local/share/nvim/site/pack/packer/start/packer.nvim

#################
### Languages ###
#################

# prep directory
RUN mkdir -p /setup/lang/
WORKDIR /setup/lang/

# python
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt install -y python3.12 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 0

# XML
RUN wget https://github.com/redhat-developer/vscode-xml/releases/download/0.26.1/lemminx-linux.zip && \
    unzip lemminx-linux.zip && \
    mv lemminx-linux /usr/bin/ && \
    chmod +x /usr/bin/lemminx-linux

# dotnet
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm -f packages-microsoft-prod.deb && \
    apt install -y dotnet-sdk-8.0
# dotnet debug
RUN wget https://github.com/Samsung/netcoredbg/releases/download/3.0.0-1018/netcoredbg-linux-amd64.tar.gz && \
    tar -xvzf netcoredbg-linux-amd64.tar.gz && \
    mv ./netcoredbg/ /usr/lib/ && \
    rm netcoredbg-linux-amd64.tar.gz

# Go
RUN wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz && \
    rm -rf /usr/local/go &&\ 
    tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/bin/go && \
    rm go1.21.6.linux-amd64.tar.gz && \
    # Set the PATH for Go, "permission denied" error occurs without "sh -c"
    sh -c 'echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile'

##################
### Setup user ###
##################

# cleanup directory
RUN rm -fr /setup/

# Set the default user to dev
RUN chown -R dev:dev /home/dev/
USER dev
WORKDIR /home/dev/

######################
### Non-root stuff ###
######################

# NVM
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && export NVM_DIR=~/.nvm \
    && . ~/.nvm/nvm.sh \
    && nvm install 16.13.0 \
    && nvm use 16.13.0

