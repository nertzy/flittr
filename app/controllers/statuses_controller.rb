class StatusesController < ApplicationController

  def show
    @status = Status.new(params[:id])
  end

end
