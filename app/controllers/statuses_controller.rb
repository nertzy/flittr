class StatusesController < ApplicationController
  caches_action :show, :expires_in => 2.days
  def show
    expires_in 2.days, :public => true
    @status = Status.new(:id => params[:id])
  end
end
