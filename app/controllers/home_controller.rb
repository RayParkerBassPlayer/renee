class HomeController < ApplicationController
  def index
    @users = User.order(:email).all

  end
end
