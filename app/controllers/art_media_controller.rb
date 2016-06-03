class ArtMediaController < ApplicationController
  before_action :set_art_medium, only: [:show, :edit, :update, :destroy]

  def index
    @art_media = ArtMedium.all
  end

  def show

  end

  private

  def set_art_medium
    @art_medium = ArtMedium.find(params[:id])
  end

end
