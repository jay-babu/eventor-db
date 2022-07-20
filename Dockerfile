FROM hasura/graphql-engine:v2.8.4

# Enable the console
ENV HASURA_GRAPHQL_ENABLE_CONSOLE=false

# Enable debugging mode. It should be disabled in production.
ENV HASURA_GRAPHQL_DEV_MODE=false

# Heroku hobby tier PG has few limitations including 20 max connections
# https://devcenter.heroku.com/articles/heroku-postgres-plans#hobby-tier
ENV HASURA_GRAPHQL_PG_CONNECTIONS=20

CMD HASURA_GRAPHQL_METADATA_DATABASE_URL=$DATABASE_URL graphql-engine \
    serve \
    --server-port $PORT

