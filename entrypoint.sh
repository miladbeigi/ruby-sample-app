#!/bin/bash
set -e

# wait for db to be ready
until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USERNAME" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

# check if the cmd == bundle exec sidekiq
if [ "$1" = 'bundle' ] && [ "$2" = 'exec' ] && [ "$3" = 'sidekiq' ]; then
    echo "Running sidekiq"
    exec "$@"
fi

echo "Running Rails server"

# create database
bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails-app/tmp/pids/server.pid

# Running the main process
exec "$@"
