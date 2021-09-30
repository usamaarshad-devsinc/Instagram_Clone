# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version (2.7)

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# System dependencies
## Ruby Version
* ruby '2.7.2'
## Rails Version
* gem 'rails', '~> 5.2.6'
## Postgres Version
* gem 'pg', '~> 1.2', '>= 1.2.3'
* To install dependencies mentioned in Gemfile
  Command: 'bundle install'
# Configuration

* Mailer configurations are set for forgot password functionality.
* Default mailer sender is 'usama.arshad@devsinc.com'.
* Credentials are saved in credentails.yml.enc file.
* Devise user is named as 'account' instead of 'user'.
* Policies are written using Pundit (requirements mentioned).
* Image files are using cloudinary for storage.

# Database creation and initialization

* To setup database (create, load schema, populate with initial test data)
  Command: 'rails db:setup'
* To start Thinking Sphinx
  Commands: 'rails ts:start'
* It will create 2 users for initial testing of application.
  Email: usama.arshad@devsinc.com with password: 123456789
  Email: hassan.raza@devsinc.com with password: 123456789
  You can initially login with these credentials otherwise
  you can signup for your personal account.

# Services

* StoryExpires Job is created to destroy the story after 24 hours of creation(if it still exists).
