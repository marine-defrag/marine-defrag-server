class Overrides::PasswordsController < DeviseTokenAuth::PasswordsController
  def edit
    redirect_url = params[:redirect_url]

    begin
      trusted_host = URI.parse(ENV["CLIENT_URL"].to_s.strip).host
      uri = URI.parse(redirect_url)

      if uri.host == trusted_host
        redirect_to redirect_url, allow_other_host: true
      else
        render plain: "Unsafe redirect", status: :forbidden
      end
    rescue URI::InvalidURIError
      render plain: "Invalid redirect URL", status: :bad_request
    end
  end
end
