class StatusesController < ApplicationController
  def show
    @status = Status.new(:id => params[:id])
  end
end
