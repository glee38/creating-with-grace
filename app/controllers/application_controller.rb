class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'application'
  helper_method :to_slug

  def to_slug
    downcase.strip.gsub(" ", "-")
  end

end
