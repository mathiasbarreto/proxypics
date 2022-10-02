class Order < ApplicationRecord
  include Filterable

  has_many :photos
  
  validates :address, presence: true

  enum status: { pending: 'pending', completed: 'completed' }

  scope :filter_by_status, -> (status) { where status: status }
  scope :filter_by_created_at, -> (created_at) { where created_at: created_at }
  scope :filter_by_address, -> (address) { where("address ILIKE ?", "#{address.downcase}%")}
  scope :filter_by_period, -> (start_date, end_date) { where created_at: start_date..end_date }
end
