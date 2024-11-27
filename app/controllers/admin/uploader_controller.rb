module Admin
  class UploaderController < ApplicationController
    protect_from_forgery with: :null_session, only: %i[image]
    before_action :verify_authenticity_token, except: %i[image]

    def image
      blob = ActiveStorage::Blob.create_and_upload!(
        io: params[:file],
        filename: params[:file].original_filename,
        content_type: params[:file].content_type
      )

      render json: { location: rails_blob_url(blob, only_path: false) }, content_type: "text/html"
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "ファイルの属性が無効です: #{e.message}" }, status: :unprocessable_entity
    rescue ActiveStorage::IntegrityError => e
      render json: { error: "ファイルの整合性チェックに失敗しました: #{e.message}" }, status: :unprocessable_entity
    rescue IOError => e
      render json: { error: "ファイルを読み取れません: #{e.message}" }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: "予期しないエラーが発生しました: #{e.message}" }, status: :internal_server_error
    end
  end
end
