require 'rails_helper'


RSpec.describe Order, type: :model do # type of testing being done
  context "Validates order address" do
    it "tenha endereço" do
      order = Order.new(address: '123 Main St')
      expect(order).to be_valid
    end

    it "ele não tenha endereço" do
      order = Order.new(address: nil)
      expect(order).to_not be_valid
    end

    it 'e retorna não pode ser em branco' do
      order = Order.new(address: nil) # iniciliaza a classe Order
      order.valid? # executa o teste
      expect(order.errors[:address]).to include("can't be blank") #valida se o erro é o esperado
    end
  end
end