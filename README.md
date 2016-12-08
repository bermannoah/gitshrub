# GitShrub

A Github clone (using the Github API) written in Rails. Mostly for practice with
OAuth and API access techniques. 

[![Code Climate](https://codeclimate.com/github/bermannoah/gitshrub/badges/gpa.svg)](https://codeclimate.com/github/bermannoah/gitshrub)
[![Test Coverage](https://codeclimate.com/github/bermannoah/gitshrub/badges/coverage.svg)](https://codeclimate.com/github/bermannoah/gitshrub/coverage)

### Technical details

Ruby on Rails backend pulling data from Github's API. Authentication via hand-rolled
OAuth. Uses the Spectre CSS framework for visuals. Faraday for HTTP requests, Figaro
for keeping secrets, secret. Tests in RSpec with additional help from VCR and Webmock. 
Main page background images via UnSplash.

### Installation instructions

#### 1. Clone down the repo.

`git clone https://github.com/bermannoah/gitshrub.git` 

#### 2. Run bundle.

`bundle install`

#### 3. Create database, run migrations.

`rake db:create db:migrate db:test:prepare`

#### 4. Add your github keys.  

You'll need to set up a github app (Profile - > Settings - > OAuth Applications).
Within that preference pane you'll add http://localhost:3000 to the "Homepage URL" section,
and http://localhost:3000/auth/github/callback to the "Authorization callback URL" section.

Cool.

Now, go to your terminal and run `figaro install`. Double, then triple check that
your `.gitignore` file is ignoring your `application.yml` file. Once that's set up
go into the `application.yml` file and add your keys and secrets. It'll look something like this:

GITHUB_CLIENT_ID: lots of letters and numbers

GITHUB_CLIENT_SECRET: lots and lots and lots of letters and numbers

You'll also need to grab your personal access token (Profile - > Settings -> Personal Access Tokens) - make a new one you don't have one. Add it to your `application.yml` file:

GITHUB_USER_TOKEN: lots and lots and lots of different letters and numbers

#### 5. Make sure things are working.

Run `rspec`. If for some reason it isn't installed, run `rails g rspec:install`.

If all the tests are green, go ahead and run `rails s`, then check out the site!

(But really though you should build this on your own, for practice, if that's a thing. :))