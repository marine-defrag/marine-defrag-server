class Overrides::PasswordsController < DeviseTokenAuth::PasswordsController
  def edit
    # TEMP FIX: Allow external redirects
    redirect_to params[:redirect_url], allow_other_host: true
  end
end
