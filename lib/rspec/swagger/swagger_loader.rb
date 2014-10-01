module Rspec
  module Swagger
    class SwaggerLoader
      def initialize
        @root = JSON.parse(File.read("docs/swagger.json"))

        @resources = @root["apis"].map do |api|
          path = "#{api['path']}.json"

          if File.exists?("docs" + path)
            JSON.parse(File.read("docs" + path))
          else
            raise "file not found: docs#{path}"
          end
        end

        @root.freeze
        @resources.freeze
      end

      attr_reader :root, :resources

      # documented_paths()
      #
      # Get a list of routes that are documented. Returns an array of Strings.
      def documented_paths
        @documented_paths ||= begin
          @resources.inject([]) { |memo, r| memo += r["apis"].map { |api| api["path"] } }
        end
      end

      # operation()
      #
      # Get an operation by HTTP verb and path.
      #
      # Example: @loader.operation(:GET, "/foo")
      def operation(verb, path)
        @resources.each do |resource|
          resource["apis"].each do |api|
            api["operations"].each do |op|
              return op if op["httpMethod"] == verb.to_s && path == api["path"]
            end
          end
        end
      end
    end
  end
end
