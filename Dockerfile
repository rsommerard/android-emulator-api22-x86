FROM ubuntu:15.10

RUN apt-get update && apt-get -y install \
  qemu-kvm \
  software-properties-common \
  telnet \
  wget \
  && add-apt-repository -y ppa:webupd8team/java \
  && apt-get update \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
  && apt-get install -y oracle-java8-installer \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
  && tar xzf android-sdk_r24.4.1-linux.tgz \
  && rm -f android-sdk_r24.4.1-linux.tgz

ENV ANDROID_HOME /android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN echo y | android update sdk --filter platform-tools --no-ui -a
RUN echo y | android update sdk --filter android-22 --no-ui -a
RUN echo y | android update sdk --filter sys-img-x86-android-22 --no-ui -a

RUN echo y | android update adb

RUN echo no | android create avd -n AndroidAPI22x86 -t android-22
