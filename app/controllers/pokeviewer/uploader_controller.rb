require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class UploaderController < ApplicationController
    skip_before_action :verify_authenticity_token

    def submit
      ExtractSaveDataJob.perform_later params[:game].as_json

      render json: { message: "Data submitted for processing." }
    end
  end
end
