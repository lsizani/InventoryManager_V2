class Request < ActiveRecord::Base
  has_one :order

  validates :requested_by, presence: true
  validates :reagent_name, presence: true
  validates :requested_amount, presence:  true
  validates :requested_for_study, presence: true
  #validates :is_reagent_kit, presence: true
end
