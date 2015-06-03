class Request < ActiveRecord::Base
  self.per_page = 10
  has_one :labs
  has_one :order
  has_one :reagent

  has_many :audits


  validates :requested_by, presence: true
  validates :reagent_name, presence: true
  validates :requested_amount, presence:  true
  validates :requested_for_study, presence: true

  scope :can_order, (lambda do
                       where(:status => 'Requested')
                     end )
  delegate :ordered_date, :order_number, :to => :order, :prefix => true

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
    if self.unit_price != nil and self.ordered_amount != nil
      self.unit_price * self.ordered_amount
    else
      return 0
    end
  end

  def order
    @order = Order.find(self.order_id)
  end
end
