class Log < ActiveRecord::Base
  has_one :reagent
  belongs_to :kit_item
end
