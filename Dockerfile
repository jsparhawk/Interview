FROM ruby:3.0-alpine3.15
# Install packages
RUN apk update
RUN apk upgrade
RUN apk add curl wget bash
RUN apk add --update ruby-dev build-base
# Clean APK cache
RUN rm -rf /var/cache/apk/*

# Copy the intervie directory in the the container Interview directory
WORKDIR Interview
COPY . /Interview
RUN ls
RUN pwd
RUN ruby -v
RUN gem install bundler
RUN bundle
RUN cucumber
