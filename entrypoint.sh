#!/bin/bash
set -e

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
exec "$@"
