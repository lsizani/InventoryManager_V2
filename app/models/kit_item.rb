class KitItem < ActiveRecord::Base
  belongs_to :reagent
  has_many :logs

  validates :item_expiration_date, presence: true
  validates :item_name, presence: true
  validates :item_storage_location, presence: true
end
