FROM hasura/graphql-engine:v2.8.4.ubuntu

ARG ACCEPT_EULA=Y

RUN apt-get update && apt-get upgrade -y && apt-get install curl -y

RUN curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | INSTALL_PATH=/bin bash

# Enable the console
ENV HASURA_GRAPHQL_ENABLE_CONSOLE=false

# Enable debugging mode. It should be disabled in production.
ENV HASURA_GRAPHQL_DEV_MODE=false

# Heroku hobby tier PG has few limitations including 20 max connections
# https://devcenter.heroku.com/articles/heroku-postgres-plans#hobby-tier
ENV HASURA_GRAPHQL_PG_CONNECTIONS=20

ENV HASURA_GRAPHQL_METADATA_DATABASE_URL=$DATABASE_URL

WORKDIR /app

COPY . .

CMD HASURA_GRAPHQL_METADATA_DATABASE_URL=$DATABASE_URL graphql-engine \
    serve \
    --server-port $PORT

RUN sleep 30

RUN hasura metadata apply --endpoint "https://eventor-db.herokuapp.com"
RUN hasura migrate apply --all-databases --endpoint "https://eventor-db.herokuapp.com"
RUN hasura metadata reload --endpoint "https://eventor-db.herokuapp.com"
