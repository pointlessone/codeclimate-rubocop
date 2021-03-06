FROM codeclimate/alpine-ruby:b38

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk --update add ruby ruby-dev ruby-bundler build-base git && \
    bundle install -j 4 && \
    apk del build-base && rm -fr /usr/share/ri

RUN adduser -u 9000 -D app
COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code
ENV GEM_PATH /code/vendor/bundle/ruby/2.2.0

CMD ["/usr/src/app/bin/codeclimate-rubocop"]
