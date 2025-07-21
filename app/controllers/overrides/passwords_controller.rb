class Overrides::PasswordsController < DeviseTokenAuth::PasswordsController
  def redirect_options
    trusted_host = URI.parse(ENV["CLIENT_URL"].to_s.strip).host
    redirect_host = URI.parse(params[:redirect_url]).host rescue nil

    if redirect_host == trusted_host
      { allow_other_host: true }
    else
      raise ActionController::BadRequest.new("Unsafe redirect_url: #{params[:redirect_url]}")
    end
  end
end
