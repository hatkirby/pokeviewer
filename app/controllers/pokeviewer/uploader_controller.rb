require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class UploaderController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user_from_token!

    def submit
      ExtractSaveDataJob.perform_later params[:game].as_json

      render json: { message: "Data submitted for processing." }
    end

    private

      def authenticate_user_from_token!
        login = request.headers["X-User-Login"].presence
        token = request.headers["X-User-Token"].presence

        unless authenticate_pokeviewer(login, token)
          head :unauthorized
        end
      end

  end
end
