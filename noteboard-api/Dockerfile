FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install
ADD . /usr/src/app
RUN chmod +x /usr/src/app/docker-entrypoint.sh

RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
RUN bundle exec rake db:seed
RUN bundle exec rake db:create RACK_ENV=production
RUN bundle exec rake db:migrate RACK_ENV=production
RUN bundle exec rake db:seed RACK_ENV=production

ENTRYPOINT ["bash","/usr/src/app/docker-entrypoint.sh"]
CMD ["rails", "s", "-b", "0.0.0.0"]
EXPOSE 3000