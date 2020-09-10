class BlogsController < ApplicationController
  before_action :load_user
  def index
    @blogs = @user.blogs   
  end

  def show 
    @blog = @user.blogs.find(params[:id])
  end

  def load_user
    @user = User.find(params[:user_id]) 
  end
end