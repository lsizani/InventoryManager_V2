class Request < ActiveRecord::Base

  has_one :order
  has_one :reagent


  validates :requested_by, presence: true
  validates :reagent_name, presence: true
  validates :requested_amount, presence:  true
  validates :requested_for_study, presence: true
  #validates :is_reagent_kit, presence: true

  scope :can_order, (lambda do
                       where(:status => %w(Requested OBO))
                     end )

  def show_edit_link?
    self.status == 'Requested' and self.status != 'Ordered' and self.status!= 'OBO'
  end

  def show_receive_link?
    %w(Ordered OBO).include?self.status
  end

  def update_now(status)
    self.update(status: status)
  end

  def net_amount
    self.unit_price * self.ordered_amount
  end

  def order
    @order = Order.find(self.order_id)
  end
end
