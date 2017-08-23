FROM ruby:2.4-alpine

RUN adduser -u 9000 -D app

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install --no-document -g

COPY . /usr/src/app

RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-rubocop"]
