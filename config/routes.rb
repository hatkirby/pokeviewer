Pokeviewer::Engine.routes.draw do
  get '/', to: 'pokemon#index'
  post '/', to: 'uploader#submit'

  resources :pokemon, only: [:show]

end
