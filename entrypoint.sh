#!/bin/bash
set -e

# create database
bundle exec rails db:create

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails-app/tmp/pids/server.pid

exec "$@"
