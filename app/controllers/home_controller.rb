class HomeController < ApplicationController
  def index
    render :template => 'devise/session/new'
  end
end
