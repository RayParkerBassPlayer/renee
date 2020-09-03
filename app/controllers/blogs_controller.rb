class BlogsController < ApplicationController
  def index
    @user = User.find(params[:user_id]) 
    @blogs = @user.blogs   
  end
end
