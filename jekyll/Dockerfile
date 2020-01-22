FROM ruby:2.6
MAINTAINER TailorDev <hello@tailordev.fr>

RUN apt-get update -qq && apt-get install -y build-essential
# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev
# for node
RUN apt-get install -y python python-dev python-pip python-virtualenv
# fix locales
RUN apt-get install -y locales
RUN echo "en_US UTF-8" > /etc/locale.gen
RUN locale-gen en_US.UTF-8
# cleanup
RUN rm -rf /var/lib/apt/lists/*
# install nodejs
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

WORKDIR /app
ONBUILD ADD . /app

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

CMD ["bash"]
