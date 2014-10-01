module Rspec
  module Swagger
    module RoutesWithNoRequiredParams
      def test_200_for_routes_with_no_required_parameters
        @loader.documented_paths.each do |api|
          unless api =~ /\{.*\}/
            # see if the API returns a 200 code
            begin
              get api

              @formatter.format passed:     last_response.status == 200,
                                left_text:  api,
                                right_text: "was <#{last_response.status}>"
            rescue
              @formatter.format passed:     false,
                                left_text:  api,
                                right_text: "<#{$!.message}>"
            end

            # see if the 200 response is documented
            if operation = @loader.operation(:GET, api)
              passed = false

              operation["responseMessages"].each do |msg|
                passed = true if msg["code"] == 200
              end

              @formatter.format passed:     passed,
                                left_text:  api,
                                right_text: "200 #{"<not> " unless passed}<documented>"
            end
          end
        end
      end
    end
  end
end
