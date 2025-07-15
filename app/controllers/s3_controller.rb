class S3Controller < ApplicationController
  after_action :verify_authorized, except: :sign

  def sign
    render json: {error: "Not configured"} and return unless defined?(::FogStorage)

    unless UPLOAD_ALLOWED_MIME_TYPES.include?(params[:contentType])
      render json: { error: "File type not allowed" }, status: 422 and return
    end

    object_name = params[:objectName].to_s

    if UPLOAD_FORBIDDEN_EXTENSIONS.any? { |ext| object_name.downcase.end_with?(ext) }
      render json: { error: "File extension not allowed" }, status: 422 and return
    end

    options = {path_style: true}
    headers = {
      "Content-Type" => params[:contentType],
      "x-amz-acl" => "public-read",
    }

    object_path = "#{ENV["S3_ASSET_FOLDER"]}/#{params[:objectName]}"
    s3_url = ::FogStorage.put_object_url(ENV["S3_BUCKET_NAME"], object_path, 15.minutes.from_now.to_time.to_i, headers, options)
    url = "#{ENV["AWS_ENDPOINT"]}/#{ENV["S3_BUCKET_NAME"]}/#{object_path}?#{URI(s3_url).query}"

    render json: {signedUrl: url}
  end
end
