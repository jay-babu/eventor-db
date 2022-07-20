FROM hasura/graphql-engine:v2.8.4.cli-migrations-v3

# Enable the console
ENV HASURA_GRAPHQL_ENABLE_CONSOLE=false

# Enable debugging mode. It should be disabled in production.
ENV HASURA_GRAPHQL_DEV_MODE=false

# Heroku hobby tier PG has few limitations including 20 max connections
# https://devcenter.heroku.com/articles/heroku-postgres-plans#hobby-tier
ENV HASURA_GRAPHQL_PG_CONNECTIONS=20

WORKDIR /app

COPY . .

ENV HASURA_GRAPHQL_MIGRATIONS_DIR=migrations
ENV HASURA_GRAPHQL_METADATA_DIR=metadata

CMD HASURA_GRAPHQL_METADATA_DATABASE_URL=$DATABASE_URL graphql-engine \
    serve \
    --server-port $PORT

