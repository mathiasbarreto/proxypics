class Order < ApplicationRecord
  include Filterable

  has_many_attached :images, dependent: :destroy

  validates :address, presence: true, length: { maximum: 50 }
  enum status: { pending: 'pending', completed: 'completed' }

  scope :filter_by_status, -> (status) { where status: status }
  scope :filter_by_address, -> (address) { where("lower (address) ILIKE :value", value: "%#{address.downcase}%")}
  scope :filter_by_date, -> (start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day...end_date.to_date.end_of_day) }
end
