# HTML Indexing API

Simple API for indexing information from URLs.

## To run app

* `bundle install`

* `rake db:setup`

* `rails s -b webrick`

## To run specs

* `rspec spec`

## Routes

* POST `/pages`
  * Index a URL
  * PARAMS: url - URL to be indexed
* GET `/pages`
  * List information for all indexed URLs as JSON
