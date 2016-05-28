class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    request.env["omniauth.auth"]
  end
  alias_method :facebook, :all
end
