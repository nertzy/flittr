class UsersController < ApplicationController
  def show
    @user = User.new(:screen_name => params[:id])
  end
end
