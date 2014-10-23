class Reagent < ActiveRecord::Base
  belongs_to :order
  has_many :kit_items

  validates :item_lot_no, presence: true
  validates :expiration_date, presence: true
  validates :delivered_amount, presence: true
  validates :storage_location, presence: true
end
