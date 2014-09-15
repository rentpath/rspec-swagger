require 'spec_helper'

require 'doctor-swagger'


describe 'The Swagger documentation' do

  it 'accurately describes the API' do
  end
end

require 'json'
Dir.mkdir( 'docs' ) unless Dir.exists? 'docs'
File.open( 'docs/swagger.json', 'w+' ) do |file|
  file.puts Rspec::Swagger.swagger_doc.as_json.to_json
end






