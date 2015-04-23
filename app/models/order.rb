class Order < ActiveRecord::Base
  has_many :requests
  validates :order_no, presence: true

  def update_now(params)
      self.update(status: 'Ordered')

      new_num = OrderNumberCount.first.order_number + 1
      OrderNumberCount.first.update(order_number: new_num)

      Request.where(supplier: self.supplier).each do |r|
        r.update(status: 'Ordered', order_id: self.id)
      end

      params[:ordered_amount].each do |om|
        Request.find(om[0]).update(ordered_amount: om[1])
      end

      params[:catalog_no].each do |om|
        Request.find(om[0]).update(catalog_no: om[1])
      end

      params[:unit_price].each do |om|
        Request.find(om[0]).update(unit_price: om[1])
      end
  end

  def is_delivered?
    %w(OBO DELIVERED).include?self.status
  end

  def sub_total
    sum = 0
    self.requests.each do |re|
      sum += re.net_amount
    end
    return sum
  end

  def vat_amount
    self.sub_total * 0.14
  end

  def final_total
    self.sub_total + self.vat_amount
  end

end
