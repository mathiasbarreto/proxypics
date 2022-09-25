class Order < ApplicationRecord    
  has_many  :photos
  
  validates :address, presence: true

  enum status: { pending: 'Pending', completed: 'Completed' }
end
