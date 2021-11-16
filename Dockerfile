FROM ruby:3.0.2-slim
ENV PORT 3000
EXPOSE $PORT

# Run as root to install dependencies and set up user
RUN apt-get update -qq &&\
    apt-get install -y curl libpq-dev git-core postgresql-client build-essential --no-install-recommends &&\
    curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    apt-get install -y nodejs

RUN adduser deploy && mkdir /app && chown -R deploy /app/

# Run as the 'deploy' user
USER deploy
WORKDIR /app
ADD . /app
RUN gem install bundler
RUN bundle install
CMD bundle exec rails server -b 0.0.0.0 -p $PORT
