class UsersController < ApplicationController
  caches_action :show, :expires_in => 10.minutes
  def show
    expires_in 10.minutes, :public => true
    @user = User.new(:screen_name => params[:id])
  end
end
