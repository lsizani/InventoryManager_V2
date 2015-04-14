class Order < ActiveRecord::Base
  belongs_to :request
  has_one :reagent

  validates :order_no, presence: true
  validates :ordered_amount, presence: true

end
