class Reagent < ActiveRecord::Base
  belongs_to :request
  has_many :kit_items

  delegate :is_reagent_kit, :reagent_name, :requested_date, :order,  :to => :request, :prefix => true

  validates :item_lot_no, presence: true
  validates :expiration_date, presence: true
  validates :delivered_amount, presence: true
  validates :storage_location, presence: true

  scope :on_or_before, (lambda do |date|
         where(:received_date => Date.new(1990, 1, 1)..date)
  end )


  def update_now
    self.update(amount_left:self.delivered_amount)
    self.request.update(status:'Delivered', date_last_changed:Date.today)
    self.request.order.update(status:'Delivered', last_date_updated: Date.today, date_last_changed:Date.today)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |reagent|
        csv << reagent.attributes.values_at(*column_names)
      end
    end
  end

  def about_to_expire?
    self.expiration_date.year == Date.today.year and self.expiration_date.month - Date.today.month <= 1
  end

end
