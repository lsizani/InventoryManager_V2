class Log < ActiveRecord::Base
  has_one :reagent
  belongs_to :kit_item

  validates :for_study, presence: true
  validates :opened_by, presence: true
  validates :opened_date, presence: true
  validates :number, presence: true
end
