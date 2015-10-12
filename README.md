# Ditto Labs Ruby Gem

[![Build Status](https://travis-ci.org/dittolabs/ditto-ruby-gem.svg?branch=travis-ci)](https://travis-ci.org/dittolabs/ditto-ruby-gem)
[![Code Climate](https://codeclimate.com/github/dittolabs/ditto-ruby-gem/badges/gpa.svg)](https://codeclimate.com/github/dittolabs/ditto-ruby-gem)
[![Coverage Status](https://coveralls.io/repos/dittolabs/ditto-ruby-gem/badge.svg?branch=master&service=github)](https://coveralls.io/github/dittolabs/ditto-ruby-gem?branch=master)

A Ruby wrapper for the Ditto Labs Photo Reader API.

## Installation

```
gem install ditto_api
```

## Ditto Photo Reader API

The Photo Reader API allows you to process images using Ditto's image recognition engine. Given the URL of the image, it will identify:

* brand logos, including the match strength and the logo bounding box,
* any faces and their bounding boxes,
* any smiles or similar facial expressions, along with a score indicating if the mood is positive or negative

## Usage

```ruby
require "ditto"

client = Ditto::Client.new(ENV["DITTO_CLIENT_ID"])
image = client.find("http://www.example.com/foo.png", "sample_id")
```

Any faces, smiles, or logos found in the image can be accessed with the `image.faces`, `image.moods`, or `image.logos` methods, respectively.
