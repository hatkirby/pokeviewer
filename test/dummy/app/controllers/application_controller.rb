class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

    def authenticate_pokeviewer(login, token)
      login == "testuser" and token == "testpass"
    end
end
