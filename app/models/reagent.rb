class Reagent < ActiveRecord::Base
  validates :item_lot_no, presence: true
  validates :expiration_date, presence: true
  validates :delivered_amount, presence: true
  validates :storage_location, presence: true
end
