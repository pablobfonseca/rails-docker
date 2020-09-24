FROM ruby:2.7
MAINTAINER pablofonseca777@gmail.com

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# rails
RUN gem install rails bundler
COPY drkiq/Gemfile Gemfile
WORKDIR /opt/app/drkiq
RUN bundle install

VOLUME ["$INSTALL_PATH/public"]
CMD bundle exec unicorn -c config/unicorn.rb
