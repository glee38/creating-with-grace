class UsersController < ApplicationController
  def index
    @users = User.where(role: 2)
  end
end