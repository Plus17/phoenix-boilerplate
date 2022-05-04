ARG MIX_ENV="prod"

# build stage
FROM plus17/phoenix-alpine:1.13.4-1.6.6 AS build

# sets work dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

COPY assets/package.json assets/package-lock.json ./assets/
RUN cd assets && npm ci

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

# copy compile configuration files
RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/

# compile dependencies
RUN mix deps.compile

# copy assets
COPY priv priv
COPY assets assets

# Compile assets
RUN mix assets.deploy

# compile project
COPY lib lib
RUN mix compile

# copy runtime configuration file
COPY config/runtime.exs config/

# assemble release
RUN mix release

# app stage
FROM alpine:3.15 AS app

ENV REPLACE_OS_VARS=true

ARG MIX_ENV

# install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR "/home/app"

# copy release executables
COPY --from=0 /app/_build/"${MIX_ENV}"/rel/app_name ./

CMD PORT=$PORT exec bin/app_name start
