class UsersController < ApplicationController
  def show
    @user = User.new(:name => params[:id])
  end

end
