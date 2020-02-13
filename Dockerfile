FROM maven:3.3-jdk-8

LABEL maintainer="javier.boo@aiwin.es"

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list && \
  echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list && \
  sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list && \
  apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get update && apt-get install -y jq zip python git

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py" && \
  python /tmp/get-pip.py && \
  pip install awscli --ignore-installed six

RUN git clone https://github.com/aiwin-tools/devops-scripts.git "$HOME/scripts"

ADD settings.xml $MAVEN_CONFIG
