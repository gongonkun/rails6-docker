FROM ruby:3.0

ENV BUNDLE_GEMFILE=/app/Gemfile \
  BUNDLE_JOBS=2 \
  RAILS_ENV=development \
  LANG=C.UTF-8

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev nodejs yarn

RUN apt remove -y libmariadb-dev-compat libmariadb-dev
RUN wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-common_8.0.18-1debian10_amd64.deb \
  https://dev.mysql.com/get/Downloads/MySQL-8.0/libmysqlclient21_8.0.18-1debian10_amd64.deb \
  https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client-core_8.0.18-1debian10_amd64.deb \
  https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-community-client_8.0.18-1debian10_amd64.deb \
  https://dev.mysql.com/get/Downloads/MySQL-8.0/libmysqlclient-dev_8.0.18-1debian10_amd64.deb

RUN dpkg -i mysql-common_8.0.18-1debian10_amd64.deb \
  libmysqlclient21_8.0.18-1debian10_amd64.deb \
  mysql-community-client-core_8.0.18-1debian10_amd64.deb \
  mysql-community-client_8.0.18-1debian10_amd64.deb \
  libmysqlclient-dev_8.0.18-1debian10_amd64.deb

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
