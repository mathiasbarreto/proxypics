class ApplicationController < ActionController::Base
  before_action :authenticate!

  def authenticate!
    unless requester_signed_in? || assignee_signed_in?
      authenticate_requester! || authenticate_assignee!
    end
  end
end
