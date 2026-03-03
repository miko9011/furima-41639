#!/usr/bin/env bash
set -o errexit

bundle install
RAILS_ENV=production bin/rails assets:precompile
RAILS_ENV=production bin/rails assets:clean
RAILS_ENV=production bin/rails db:migrate