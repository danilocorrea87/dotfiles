#!/bin/bash
# set -e

ASDF_BOOTSTRAP="${HOME}/.asdf/asdf.sh"
ASDF_VERSION="v0.8.1"

BASHRC_PATH="${HOME}/.bashrc"
ZSHRC_PATH="${HOME}/.zshrc"
USR_LOCAL_BIN_PATH="/usr/local/bin"

sudo apt-get update -y

sudo apt-get install -y \
        git \
        vim \
        wget \
        curl \
        zsh \
        build-essential \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        tmux \
        make \
        autoconf \
        bison \
        gettext \
        libgd-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libicu-dev \
        libjpeg-dev \
        libmysqlclient-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libzip-dev \
        openssl \
        pkg-config \
        re2c \
        zlib1g-dev \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        llvm \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev        


if ! command -v docker &> /dev/null
then
    # Versões mais antigas do docker eram chamadas de docker, docker.io
    # ou docker-engine. Se estiverem instalados, o comando abaixo vai desinstalar todos eles.
    sudo apt-get remove \
        docker \
        docker-engine \
        docker.io \
        containerd \
        runc

    DRY_RUN=1
    sudo -u $(whoami) curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm -rf get-docker.sh
fi

if ! command -v docker-compose &> /dev/null
then
    sudo curl \
        -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
        -o "${USR_LOCAL_BIN_PATH}/docker-compose"

    sudo chmod +x "${USR_LOCAL_BIN_PATH}/docker-compose"
fi

# Install adsf
if ! command -v asdf &> /dev/null
then
    rm -rf ~/.asdf
    sudo -u $(whoami) git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "${ASDF_VERSION}"
    
    if ! grep -Fxq ". ${ASDF_BOOTSTRAP}" "${BASHRC_PATH}"
    then
        sudo -u $(whoami) echo . "${ASDF_BOOTSTRAP}" >> "${BASHRC_PATH}"
    fi

    sudo -u $(whoami) chown -R "$(whoami).$(whoami)" "${BASHRC_PATH}"
    . "${ASDF_BOOTSTRAP}"
fi

ASDF_PLUGINS_INSTALLED=$(asdf plugin list)

echo -e "plugins instalados: ${ASDF_PLUGINS_INSTALLED} \n"

if ! test "${ASDF_PLUGINS_INSTALLED#*php}" != "${ASDF_PLUGINS_INSTALLED}"
then
    echo -e "Add plugin do php \n"
    sudo -u $(whoami) asdf plugin-add php https://github.com/asdf-community/asdf-php.git
    sudo -u $(whoami) asdf install php 8.0.11
    sudo -u $(whoami) asdf global php 8.0.11
fi

if ! test "${ASDF_PLUGINS_INSTALLED#*nodejs}" != "${ASDF_PLUGINS_INSTALLED}"
then
    echo -e "Add plugin do nodejs \n"
    sudo -u $(whoami) asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    sudo -u $(whoami) asdf install nodejs lts
    sudo -u $(whoami) asdf global nodejs lts
fi

if ! test "${ASDF_PLUGINS_INSTALLED#*python}" != "${ASDF_PLUGINS_INSTALLED}"
then
    echo -e "Add plugin do python \n"
    sudo -u $(whoami) asdf plugin-add python
    sudo -u $(whoami) asdf install python 2.7.18
    sudo -u $(whoami) asdf install python 3.9.7
    sudo -u $(whoami) asdf global python 3.9.7 2.7.18
fi



