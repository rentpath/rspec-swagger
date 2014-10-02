module Rspec
  module Swagger
    module RoutesWithSampleValues
      def test_sample_values_for_path_params_on_get_routes
        @loader.documented_paths.each do |api|
          if api =~ /\{.*\}/
            if operation = @loader.operation(:GET, api)
              ["200", "403", "404"].each do |code|
                api_with_values = api.clone

                operation["parameters"].each do |param|
                  if param_has_sample_value(param, code)
                    api_with_values = api_with_values.gsub("{#{param['name']}}", param["sampleValues"][code])
                  end
                end

                unless api_with_values.include?("{")
                  begin
                    get api_with_values

                    @formatter.format passed:     last_response.status.to_i == code.to_i,
                                      left_text:  api_with_values,
                                      right_text: "was <#{last_response.status}>"

                    @formatter.format passed:     last_response.status.to_i == code.to_i,
                                      left_text:  api_with_values,
                                      right_text: "#{code} <documented>"
                  rescue
                    @formatter.format passed:     false,
                                      left_text:  api_with_values,
                                      right_text: "<#{$!.message}>"

                    @formatter.format passed:     false,
                                      left_text:  api_with_values,
                                      right_text: "#{code} <documented>"
                  end
                end
              end
            end
          end
        end
      end

      private

      def param_has_sample_value(param, code)
        param["sampleValues"].respond_to?(:has_key?) &&
          param["sampleValues"].has_key?(code.to_s)
      end
    end
  end
end
