namespace :rspec do
  namespace :swagger do
    task default: [:install]

    desc "Install rspec-swagger."
    task install: ["docs", "docs/swagger.json", "docs/example_resource.json", "spec", "spec/swagger_spec.rb"]

    directory "docs"

    file "docs/swagger.json" do
      cp File.expand_path("../../../../templates/swagger.json", __FILE__), "docs/swagger.json"
    end

    file "docs/example_resource.json" do
      cp File.expand_path("../../../../templates/example_resource.json", __FILE__), "docs/example_resource.json"
    end

    directory "spec"

    file "spec/swagger_spec.rb" do
      cp File.expand_path("../../../../templates/swagger_spec.rb", __FILE__), "spec/swagger_spec.rb"
    end
  end
end
