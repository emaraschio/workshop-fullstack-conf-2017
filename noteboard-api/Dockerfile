FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc
ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install --jobs 20 --retry 5
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