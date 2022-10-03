module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :verify_requester_api_key
  end

  private

  def verify_requester_api_key
    return head :unauthorized unless requester_has_valid_api_key?
  end

  def requester_has_valid_api_key?
    Requester.find_by(api_key: request.headers['Authorization']
             .gsub('Bearer','').strip).present?
  end
end