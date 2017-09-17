require "enumerize"
require "sequential"

module Pokeviewer
  class Engine < ::Rails::Engine
    isolate_namespace Pokeviewer
  end
end
