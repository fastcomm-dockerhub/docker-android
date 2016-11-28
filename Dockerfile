############################################################ 
# Dockerfile to build android apps
############################################################ 

FROM ubuntu:16.04
MAINTAINER Wimpie Nortje

# Build settings
ENV GRADLE_VER=2.14.1

# Environment variables 
ENV ANDROID_HOME=/opt/android-sdk-linux \
    PATH=$PATH:/opt/gradle-${GRADLE_VER}/bin \
    JAVA_HOME=/usr/lib/jvm/java-9-openjdk-amd64

# Install packages
## 32 bit libs are for Android tools like aapt which are only available as 32b
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    lib32z1 \
    libbz2-1.0:i386 \
    openjdk-9-jre-headless \
    unzip \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Install Android SDK to /opt/android-sdk-linux

## Use this for DockerHub
RUN wget -qO- "https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" | tar -zxv -C /opt/ 

## Use this for local
#COPY ./android-sdk_r24.4.1-linux.tgz .
#RUN tar -xzf android-sdk_r24.4.1-linux.tgz && rm android-sdk_r24.4.1-linux.tgz

# Accept licenses
RUN pkgs="android-14 \
          android-18 \
          android-20 \
          android-23 \
          build-tools-23.0.2 \
          build-tools-24.0.2 \
          extra-android-m2repository \
          extra-google-m2repository \
          "; \
    for p in $pkgs; do \
        echo y | $ANDROID_HOME/tools/android update sdk -a -u -f -t $p; \
    done

# Install Gradle to /opt/gradle-${GRADLE_VER}

## Use this for DockerHub
RUN wget -qO- "https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip" | unzip gradle-${GRADLE_VER}-bin.zip

## Use this for local
#COPY gradle-${GRADLE_VER}-bin.zip .
#RUN unzip gradle-${GRADLE_VER}-bin.zip && rm gradle-${GRADLE_VER}-bin.zip

WORKDIR /root
