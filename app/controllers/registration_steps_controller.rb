class RegistrationStepsController < ApplicationController
  include Wicked::Wizard
  steps :personal
  skip_before_action :verify_completed_sign_up

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    params[:user][:status] = 'active' if step == steps.last
    @user.attributes = user_params
      if @user.save
        @profile = @user.create_profile
        @profile.username = @user.username
        @profile.save
      end
    render_wizard @user
  end

  private

  def redirect_to_finish_wizard(options = nil)
    redirect_to root_path, notice: "Thank you for signing up, #{current_user.name}!"
  end

  def user_params
    params.require(:user).permit(:name, :username, :status)
  end
end
