FROM ruby:3.1.2-alpine

RUN apk update && apk add --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  git \
  nodejs \
  yarn \
  bash \
  && rm -rf /var/cache/apk/*

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN chmod +x ./entrypoint.sh && mv ./entrypoint.sh /usr/bin
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8080

CMD ["rails", "server", "-p", "8080"]