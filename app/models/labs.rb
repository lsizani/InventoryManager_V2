class Labs < ActiveRecord::Base
  belongs_to :request

  validates :name, presence: true
end
