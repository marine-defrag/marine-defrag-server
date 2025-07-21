class Overrides::PasswordsController < DeviseTokenAuth::PasswordsController
  def edit
    redirect_url = params[:redirect_url]
    reset_password_token = params[:reset_password_token]

    unless redirect_url && reset_password_token
      return render plain: "Missing redirect URL or token", status: :bad_request
    end

    begin
      trusted_host = URI.parse(ENV["CLIENT_URL"].to_s.strip).host
      uri = URI.parse(redirect_url)
    rescue URI::InvalidURIError
      return render plain: "Invalid redirect URL", status: :bad_request
    end

    unless uri.host == trusted_host
      return render plain: "Unsafe redirect", status: :forbidden
    end

    @resource = resource_class.with_reset_password_token(reset_password_token)

    if @resource && @resource.reset_password_period_valid?
      client_id = SecureRandom.urlsafe_base64(nil, false)
      token = SecureRandom.urlsafe_base64(nil, false)
      expiry = (Time.now + DeviseTokenAuth.token_lifespan).to_i

      @resource.tokens[client_id] = {
        token: BCrypt::Password.create(token),
        expiry: expiry
      }
      @resource.save!

      query_params = {
        reset_password_token: reset_password_token,
        client_id: client_id,
        token: token,
        uid: @resource.uid,
        expiry: expiry
      }

      redirect_to "#{redirect_url}?#{query_params.to_query}", allow_other_host: true
    else
      render_edit_error
    end
  end
end
