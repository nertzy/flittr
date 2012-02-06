class SearchController < ApplicationController
  def index
    if params[:screen_name].blank?
      flash[:search_form_message] = 'Please enter a Twitter handle'
      redirect_to root_path and return if params[:screen_name].blank?
    end
    redirect_to user_path(:id => params[:screen_name])
  end
end
