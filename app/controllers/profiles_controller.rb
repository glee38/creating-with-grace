class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index  
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar. :bio)

  def set_profile
    @profile = current_user.profile
  end
end
