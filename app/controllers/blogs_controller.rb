class BlogsController < ApplicationController
  before_action :load_user

  def index
    @blogs = @user.blogs   
  end

  def show 
    @blog = @user.blogs.find(params[:id])
  end

  def new
    @blog = @user.blogs.new 
  end

  def create
    @blog = Blog.new(params[:blog].permit(Blog.whitelisted_attributes))

    if @blog.save
      # flash[:errors]
      render :new
    else
    end
  end

  def load_user
    if !params[:user_id].nil?
      @user = User.find(params[:user_id]) 
    end
  end
end
