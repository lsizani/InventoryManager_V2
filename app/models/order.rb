class Order < ActiveRecord::Base
  belongs_to :request
  delegate :reagent_name, :requested_by, :requested_for_study,:requested_amount, :requested_date, :is_reagent_kit,
           :to => :request, :prefix => true
  has_one :reagent

  validates :order_no, presence: true
  validates :ordered_amount, presence: true

  def update_now(request_id)
      self.update(status: 'Ordered')

      re = Request.find_by_id(request_id)
      re.update_now('Ordered')

      if self.supplier.blank?
        self.update(supplier: re.supplier)
      end

      if self.manufacturer.blank?
        self.update(manufacturer: re.manufacturer)
      end

      if self.catalog_no.blank?
        self.update(catalog_no:re.catalog_no)
      end
  end

  def is_delivered?
    %w(OBO DELIVERED).include?self.status
  end

  def save
    super
  end
end
