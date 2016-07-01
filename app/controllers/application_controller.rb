class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'application'
  helper_method :to_slug

  before_action :verify_completed_sign_up

  def to_slug
    downcase.strip.gsub(" ", "-")
  end

  private

  def verify_completed_sign_up
    if user_signed_in?
      if current_user.username.nil? || current_user.name.nil?
        flash.alert = "Almost done! Just one more step to complete sign up." 
        redirect_to registration_steps_personal_path
      end
    end
  end

end
