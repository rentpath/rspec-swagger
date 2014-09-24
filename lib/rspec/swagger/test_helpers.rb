module Rspec
  module Swagger
    module TestHelpers
      def test_api_correctness
        root_json = JSON.parse(File.read("docs/swagger.json"))

        resource_jsons = root_json["apis"].map do |api|
          path = "#{api['path']}.json"

          if File.exists?("docs" + path)
            JSON.parse(File.read("docs" + path))
          else
            raise "file not found: docs#{path}"
          end
        end

        resource_jsons.each do |resource_json|
          resource_json["apis"].each do |api|
            begin
              get api["path"]
              # puts "#{api['path']}: #{last_response.status}"
            rescue URI::InvalidURIError
              # TODO Try to test trickier URLs, such as /{channel}/{state}/cities
            end
          end
        end
      end
    end
  end
end
