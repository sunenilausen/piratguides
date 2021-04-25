# README

## System dependencies

* [Ruby](https://www.ruby-lang.org/en/) 2.7.1
* Node 10.19.0
* Postgresql
* Python
* Yarn
* See default.nix for more

## Configuration

nix-shell (if you use nix)
gem install bundler
bundle install
docker-compose up
bundle exec rails db:migrate

## Start

rails s

## Test suite

bundle exec rspec
