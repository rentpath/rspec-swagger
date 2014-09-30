module Rspec
  module Swagger
    module TestHelpers
      include RoutesWithNoRequiredParams

      # test_api_correctness()
      #
      # Tests the correctness of the Swagger-formatted docs stored
      # in the docs/swagger.json and docs/*.json files. You can either
      # run this method for all of the tests, or pick and choose from
      # the tests referenced in this method.
      def test_api_correctness
        @loader = SwaggerLoader.new
        @formatter = Formatter.new

        test_200_for_routes_with_no_required_parameters
      end
    end
  end
end
