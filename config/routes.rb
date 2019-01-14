Pokeviewer::Engine.routes.draw do
  get '/', to: 'pokemon#index'
  post '/', to: 'uploader#submit'

  resources :pokemon, only: [:show] do
    member do
      get 'embed'
      get 'revisions/:revision_id', action: :show_revision, as: :show_revision
    end
  end

  resources :pokedex, only: [:index]

end
