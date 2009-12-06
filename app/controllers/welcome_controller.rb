class WelcomeController < ApplicationController
  caches_action :index, :expires_in => 1.day
  def index
    expires_in 1.day, :public => true
  end
end
