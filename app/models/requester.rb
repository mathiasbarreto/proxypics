class Requester < ApplicationRecord
  before_create :set_api_key, if: :blank_api_key?

  def set_api_key
    self.api_key = SecureRandom.hex(16)
  end

  def blank_api_key?
    api_key.blank?
  end
end
