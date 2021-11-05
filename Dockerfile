FROM ruby:3.0.1-alpine3.13

WORKDIR /cwallet

COPY Gemfile Gemfile.lock ./

RUN gem update --system \
    && gem install bundler -v 2.2.15 \
    && bundle install

COPY . .
