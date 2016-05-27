class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :personal

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = user_params
    render_wizard @user
  end

  private

  def redirect_to_finish_wizard(options = nil)
    redirect_to root_path, notice: "Thank you for signing up, #{current_user.name}!"
  end

  def user_params
    params.require(:user).permit(:name, :username)
  end
end
