############################################################ 
# Dockerfile to run Selenium tests on desktop browsers
############################################################ 

FROM ubuntu:16.04

# Install packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    ruby-dev \
    zlibc \
    zlib1g-dev \
    qt5-default \
    libqt5webkit5-dev \
    nodejs-legacy \
    chromium-chromedriver \
    libgconf-2-4 \
    xvfb \
    wget \
    git \
    less

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y \
    google-chrome-stable \
 && rm -rf /var/lib/apt/lists/*

# Install Bundler
RUN gem install bundle && \
    echo "gem: --no-document" >> ~/.gemrc

# Prepare the CI working directory
WORKDIR /tmp/build
