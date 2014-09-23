require 'spec_helper'

describe Rspec::Swagger do
  include Rspec::Swagger::TestHelpers

  it "should describe the api" do
    test_api_correctness
  end
end
