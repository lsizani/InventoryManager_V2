require 'rails_helper'

RSpec.describe Order, :type => :model do

  context 'when creating a new order' do
    it 'raises an error when saving it without an order number' do
      order = Order.new(order_no:nil, ordered_amount: 5)
      expect {order.save!}.to raise_error
    end

    it 'raises an error when saving it without an ordered amount' do
      order = Order.new(order_no:1234, ordered_amount: nil)
      expect {order.save!}.to raise_error
    end
  end
end
