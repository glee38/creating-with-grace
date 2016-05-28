class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in @user
      if @user.name && @user.username
        redirect_to root_path, notice: "Signed in successfully."
      else
        redirect_to registration_steps_path(@user), notice: "Successfully authenticated via Facebook! Just one more step to complete sign up."
      end
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_path
    end
  end
  alias_method :facebook, :all
end
