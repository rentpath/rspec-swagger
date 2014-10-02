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
                  if sample_value = sample_value_from_param(param, code)
                    api_with_values = api_with_values.gsub("{#{param['name']}}", sample_value)
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

      def sample_value_from_param(param, code)
        has_sample_values_hash = param["sampleValues"].respond_to?(:has_key?) &&
          param["sampleValues"].has_key?(code.to_s)

        if has_sample_values_hash
          if param["sampleValues"][code.to_s].respond_to?(:has_key?)
            param["sampleValues"][code.to_s][environment]
          else
            param["sampleValues"][code.to_s]
          end
        end
      end

      def environment
        ENV["ENVIRONMENT"] || "development"
      end
    end
  end
end
