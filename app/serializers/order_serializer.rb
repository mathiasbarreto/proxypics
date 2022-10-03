class OrderSerializer < ActiveModel::Serializer
  attributes :id, :address, :status, :errors
end
