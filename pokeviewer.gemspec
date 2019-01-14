$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pokeviewer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pokeviewer"
  s.version     = Pokeviewer::VERSION
  s.authors     = ["Kelly Rauchenberger"]
  s.email       = ["fefferburbia@gmail.com"]
  s.homepage    = "https://github.com/hatkirby/pokeviewer"
  s.summary     = "Rails engine that displays Pokémon."
  s.description = "Pokeviewer is a web interface that lets you display Pokémon that have been uploaded from a GBA using hatkirby/gen3uploader."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "enumerize"
  s.add_dependency "sequenced"
  s.add_dependency "activerecord-diff"
  s.add_dependency "haml"
  s.add_dependency 'sassc-rails'
  s.add_dependency 'normalize-rails'
  s.add_dependency 'coffee-rails', '~> 4.2'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'victor'

  s.add_development_dependency "sqlite3"
end
