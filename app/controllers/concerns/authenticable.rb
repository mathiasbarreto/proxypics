module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :verify_api_key
  end

  private

  def verify_api_key
    return head :unauthorized unless has_valid_api_key?
  end

  def has_valid_api_key?
    Requester.find_by(apikey: request.headers['Authorization'].gsub('Bearer','').strip).present?
  end
end