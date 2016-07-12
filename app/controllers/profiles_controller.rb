class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_profile, only: [:create, :edit, :update, :destroy]

  def index  
  end

  def show
  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    if @profile.save
      flash[:notice] = "Profile was successfully updated."
      redirect_to profile_path(@profile)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar, :bio)
  end

  def set_profile
    @profile = Profile.find_by_slug(params[:id])
  end

  def set_user
    @user = @profile.user
  end

  def authorize_profile
    authorize @profile
  end

end
