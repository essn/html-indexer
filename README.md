# HTML Indexing API

Simple API for indexing information from URLs.

## To run app

* `bundle install`

* `rake db:setup`

* `rails s -b webrick`

## To run specs

* `rspec spec`

## Routes

* GET `/pages/:url`
  * Get the information for a single URL as JSON
* GET `/pages`
  * List information for all URLs as JSON
