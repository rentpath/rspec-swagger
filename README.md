# Rspec Swagger
Generate Swagger docs from your specs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-swagger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-swagger

## Usage

##### RSpec

Place your Swagger documentation in docs/swagger.json and docs/*.json. Then,
drop the following in a test file in your test suite:

```ruby
require 'spec_helper'

describe Rspec::Swagger do
  include Rspec::Swagger::TestHelpers

  it "should describe the api" do
    test_api_correctness
  end
end
```

This gem is designed for use with [rack-swagger](http://www.github.com/rentpath/rack-swagger).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-swagger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
