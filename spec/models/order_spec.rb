require 'rails_helper'

RSpec.describe Order, :type => :model do

  context 'when creating a new order' do
    it 'raises an error when saving it without an order number' do
      order = Order.new(order_no:nil)
      expect {order.save!}.to raise_error
    end
  end
end
