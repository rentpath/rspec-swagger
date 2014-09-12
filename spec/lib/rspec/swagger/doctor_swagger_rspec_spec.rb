require 'spec_helper'

require 'doctor-swagger'

module Rspec
  module Swagger
  	swagger_version 'some crazy version'
  	api_version '3.0'
  	base_path       'https://example.com/api'

  	swagger_resource '/products' do
  	  endpoint '/products' do
  	    description 'Products'

  	    operation :index do
  	      header_parameter :api_key do
  	        description 'The api key issued to your app'
  	        required!
  	        type :string
  	      end

  	      query_parameter :category_id do
  	        description 'The category id of the products you want'
  	        required!
  	        type :integer
  	      end

  	      method :get
  	      notes 'Returns lots of products'

  	      type '[product]'
  	      internal_type '[Product]'

  	      standard_errors
  	      error 418, "im_a_teapot"

  	      embeds :category, :variants
  	      scopes 'read-inventory', 'other-scope'
  	      summary 'Find products by category id'
  	    end
  	  end

  	  endpoint '/products/{product_id}' do
  	    description 'Show product'

  	    operation :show do
  	      path_parameter :product_id do
  	        description 'The product id of the product you want'
  	        required!
  	        type :integer
  	      end

  	      method :get
  	      notes 'Returns a product'

  	      type 'product'
  	      internal_type 'Product'

  	      standard_errors
  	      embeds :category, :variants
  	      scopes 'read-inventory', 'other-scope'
  	      summary 'Find product by product id'
  	    end

  	    operation :update do
  	      path_parameter :product_id do
  	        description 'The product id of the product you want'
  	        required!
  	        type :integer
  	      end

  	      post_body do
  	        description 'The JSON representation of the product'
  	        required!

  	        example 'product' => {
  	          'foo' => 'bar',
  	          'wat' => nil
  	        }
  	      end

  	      method :put
  	      notes <<-EOS
  	# Updates a *product*
  	EOS

  	      type 'product'
  	      internal_type 'Product'

  	      standard_errors
  	      scopes 'read-inventory', 'other-scope'
  	      summary 'Update product by product id'
  	    end
  	  end
  	end
  end
end
require 'json'
Dir.mkdir( 'docs' ) unless Dir.exists? 'docs'
File.open( 'docs/swagger.json', 'w+' ) do |file|
  file.puts Rspec::Swagger.swagger_doc.as_json.to_json
end






