Pokeviewer::Engine.routes.draw do
  get '/', to: 'pokemon#index'
  post '/', to: 'uploader#submit'

  resources :pokemon, only: [:show] do
    member do
      get 'embed'
    end
  end

  resources :pokedex, only: [:index]

end
