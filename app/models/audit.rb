class Audit < ActiveRecord::Base
  belongs_to :kit_item
  belongs_to :order
  belongs_to :reagent
  belongs_to :request

end
