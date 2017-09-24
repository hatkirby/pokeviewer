Pokeviewer::Engine.routes.draw do
  post '/', to: 'uploader#submit'

  resources :pokemon, only: [:index, :show]

end
