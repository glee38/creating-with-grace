class WelcomeController < ApplicationController
  def index
    @posts = Post.all
  end

  def single
  end
end