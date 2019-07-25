FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

RUN gem install bundler
RUN bundle install

ADD . $APP_HOME

EXPOSE 3001

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]