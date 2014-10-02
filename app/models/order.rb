class Order < ActiveRecord::Base
  validates :order_no, presence: true
  validates :ordered_amount, presence: true
end
