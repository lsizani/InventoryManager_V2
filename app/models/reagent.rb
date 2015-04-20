class Reagent < ActiveRecord::Base
  belongs_to :order
  has_many :kit_item

  validates :item_lot_no, presence: true
  validates :expiration_date, presence: true
  validates :delivered_amount, presence: true
  validates :storage_location, presence: true

  def update(attributes)
    super
    update_now(self)
  end

  def update_now(reagent)
    re = Reagent.find(reagent.id)
    order = Order.find(re.order.id)
    request = Request.find(order.request_id)
    amount_left = 0
    bo_amount = 0
    bo_status = false
    status = ''

    #if order.on_back_order then we're editing a reagent
    if order.on_back_order
      #if we're here then this is to update a back ordered reagent
      #check if delivery amount <= requested amount:
      if order.back_order_amount <= reagent.delivered_amount
        #if all the requested quantity has been delivered
        amount_left = re.amount_left + reagent.delivered_amount
        status = 'Delivered'
      end
      if order.back_order_amount > reagent.delivered_amount
        amount_left = re.amount_left + reagent.delivered_amount
        status = 'OBO'
      end

    else
      if order.ordered_amount <= reagent.delivered_amount
        status = 'Delivered'
        bo_status = false
        bo_amount = 0
        amount_left = reagent.delivered_amount
      end
      if order.ordered_amount > reagent.delivered_amount
        status = 'OBO'
        bo_status = true
        bo_amount = order.ordered_amount - reagent.delivered_amount
        amount_left = reagent.delivered_amount
      end
    end

    re.update(order_id: order_id, amount_left: amount_left, status: status, date_last_changed:Date.today,
              last_changed_by: current_user_full_name, last_date_updated: Date.today)
    order.update(on_back_order: bo_status, back_order_delivery_date: Date.today, back_order_amount: bo_amount, status: status)
    request.update(status:status)

  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |reagent|
        csv << reagent.attributes.values_at(*column_names)
      end
    end
  end

end
