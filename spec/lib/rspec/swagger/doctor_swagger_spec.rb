require 'spec_helper'

describe Rspec::Swagger do

  it "builds the Swagger API from the DSL" do
    expected_result = {
      'apiVersion' => '3.0',
      'swaggerVersion' => 'some crazy version',
      'basePath' => "https://example.com/api",
      'resourcePath' => '/products',
      'models' => {"Product"=>{"id"=>"Product", "properties"=>{"product_id"=>{"type"=>"integer", "format"=>"int64"}}}},
      'apis' => [
        {
          'path' => '/products',
          'description' => 'Products',
          'operations' => [
            {
              'parameters' => [
                {
                  'name' => 'api_key',
                  'description' => 'The api key issued to your app',
                  'dataType' => 'string',
                  'required' => true,
                  'allowMultiple' => false,
                  'paramType' => 'header'
                },
                {
                  'name' => 'category_id',
                  'description' => 'The category id of the products you want',
                  'dataType' => 'integer',
                  'required' => true,
                  'allowMultiple' => false,
                  'paramType' => 'query'
                },
                {
                  'name' => 'embedded',
                  'description' => 'Optional records to embed, comma-separated',
                  'dataType' => 'string',
                  'required' => false,
                  'allowMultiple' => true,
                  'paramType' => 'query',
                  'allowableValues' => {
                    'values' => %w[category variants],
                    'valueType' => 'LIST'
                  }
                }
              ],
              'httpMethod' => 'GET',
              'notes' => "<p>Returns lots of products</p>\n",
              'embeds' => %w[category variants],
              'scopes' => %w[read-inventory other-scope],
              'responseTypeInternal' => '[Product]',
              'responseClass' => '[product]',
              'errorResponses' => [
                {
                  'error' => 'resource_not_found',
                  'http_status' => 404
                },
                {
                  'error' => 'access_denied',
                  'http_status' => 401
                },
                {
                  'error' => 'im_a_teapot',
                  'http_status' => 418
                }
              ],
              'summary' => 'Find products by category id',
              'nickname' => 'index'

            }
          ]
        },
        {
          'path' => '/products/{product_id}',
          'description' => 'Show product',
          'operations' => [
            {
              'parameters' => [
                {
                  'name' => 'product_id',
                  'description' => 'The product id of the product you want',
                  'dataType' => 'integer',
                  'required' => true,
                  'allowMultiple' => false,
                  'paramType' => 'path'
                },
                {
                  'name' => 'embedded',
                  'description' => 'Optional records to embed, comma-separated',
                  'dataType' => 'string',
                  'required' => false,
                  'allowMultiple' => true,
                  'paramType' => 'query',
                  'allowableValues' => {
                    'values' => %w[category variants],
                    'valueType' => 'LIST'
                  }
                }

              ],
              'httpMethod' => 'GET',
              'notes' => "<p>Returns a product</p>\n",
              'embeds' => %w[category variants],
              'scopes' => %w[read-inventory other-scope],
              'responseTypeInternal' => 'Product',
              'responseClass' => 'product',
              'errorResponses' => [
                {
                  'error' => 'resource_not_found',
                  'http_status' => 404
                },
                {
                  'error' => 'access_denied',
                  'http_status' => 401
                }
              ],
              'summary' => 'Find product by product id',
              'nickname' => 'show',
              'scopes' => %w[read-inventory other-scope]

            },
            {
              'parameters' => [
                {
                  'name' => 'product_id',
                  'description' => 'The product id of the product you want',
                  'dataType' => 'integer',
                  'required' => true,
                  'allowMultiple' => false,
                  'paramType' => 'path'
                },
                {
                  'name' => 'body',
                  'description' => 'The JSON representation of the product',
                  'dataType' => 'string',
                  'required' => true,
                  'allowMultiple' => false,
                  'paramType' => 'post',
                  'example'   => {
                    'product' => {
                      'foo' => 'bar',
                      'wat' => nil
                    }
                  }
                },
              ],
              'httpMethod' => 'PUT',
              'notes' => "<h1>Updates a <em>product</em></h1>\n",
              'embeds' => %w[],
              'scopes' => %w[read-inventory other-scope],
              'responseTypeInternal' => 'Product',
              'responseClass' => 'product',
              'errorResponses' => [
                {
                  'error' => 'resource_not_found',
                  'http_status' => 404
                },
                {
                  'error' => 'access_denied',
                  'http_status' => 401
                }
              ],
              'summary' => 'Update product by product id',
              'nickname' => 'update',
              'scopes' => %w[read-inventory other-scope]

            }
          ]
        }
      ]
    }
    expect(Rspec::Swagger.swagger_doc.as_json).to eq(expected_result)
  end
end
