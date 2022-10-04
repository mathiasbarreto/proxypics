class HomeController < ApplicationController
  skip_before_action :authenticate_requester!
  
  def index
  end
end