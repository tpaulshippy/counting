# syntax=docker/dockerfile:1
FROM ruby:3.2.1
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /app
ADD . /app
RUN gem install bundler
RUN bundle install

ENV PORT=3000

EXPOSE $PORT

# Configure the main process to run when running the image
CMD rails server -b 0.0.0.0 -p $PORT