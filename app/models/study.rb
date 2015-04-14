class Study < ActiveRecord::Base

  validates :study_number, presence: true
  validates :study_start_date, presence: true
  validates :study_end_date, presence: true

end
