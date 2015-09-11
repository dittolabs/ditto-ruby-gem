Gem::Specification.new do |s|
  s.name = "ditto_api"
  s.version = "0.0.1"
  s.summary = "A Ruby interface to the Ditto Photo Reader API."
  s.license = "MIT"
  s.author = "Adam Sheehan"
  s.email = "adam@ditto.us.com"
  s.files = `git ls-files lib`.split("\n")
  s.add_development_dependency("rake", "~> 10.0")
  s.add_development_dependency("rspec", "~> 3.0")
end
