class KitItem < ActiveRecord::Base
  belongs_to :reagent
  has_many :logs
end
