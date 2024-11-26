class Admin::UploaderController < ApplicationController
  protect_from_forgery with: :null_session, only: %i[image]
  before_action :verify_authenticity_token, except: %i[image]

  def image
    blob = ActiveStorage::Blob.create_and_upload!(
      io:           params[:file],
      filename:     params[:file].original_filename,
      content_type: params[:file].content_type
    )

    render json: { location: rails_blob_url(blob, only_path: false) }, content_type: "text/html"
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
