class HomeController < ApplicationController
  skip_before_action :authenticate_requester!, only: :home
  
  def index
  end
end