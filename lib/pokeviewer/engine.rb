require "enumerize"
require "sequenced"
require "haml"
require "sass-rails"
require "normalize-rails"
require "jquery-rails"

module Pokeviewer
  class Engine < ::Rails::Engine
    isolate_namespace Pokeviewer

    initializer "pokeviewer.assets" do |app|
      app.config.assets.paths << root.join("app", "assets", "fonts")
    end

    initializer "pokeviewer.assets" do |app|
      app.config.assets.precompile +=
        %w(pokeviewer/icons/*.png
          pokeviewer/sprites/**/*.png
          pokeviewer/sprites/**/*.gif
          pokeviewer/types/*.gif
          pokeviewer/boxes/*.png
          pokeviewer/ribbons/*.png
          pokeviewer/items/*.png
          pokeviewer/items/**/*.png
          pokeviewer/*.png)
    end
  end
end
