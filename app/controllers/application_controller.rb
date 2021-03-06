class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :exception
  layout 'application'
  helper_method :to_slug

  before_action :verify_completed_sign_up

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized(exception)
    if user_signed_in?
      flash[:error] = "You must be an admin to do that."
      redirect_to(request.referrer || root_path)
    else
      flash[:error] = "Please login or sign up."
      redirect_to(request.referrer || root_path)
    end
  end

end
