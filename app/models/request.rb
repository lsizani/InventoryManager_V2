class Request < ActiveRecord::Base
  has_one :order

  validates :requested_by, presence: true
  validates :reagent_name, presence: true
  validates :requested_amount, presence:  true
  validates :requested_for_study, presence: true
  #validates :is_reagent_kit, presence: true

  def show_edit_link?
    self.status == 'Requested' and self.status != 'Ordered' and self.status!= 'OBO'
  end

  def show_order_link?
    self.status != 'Ordered' and self.status != 'Delivered' and self.status != 'OBO'
  end

  def update_now(status)
    self.update(status: status)
  end
end
