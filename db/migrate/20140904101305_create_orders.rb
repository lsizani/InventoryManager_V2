class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer  :request_id
      t.string   :order_no
      t.string   :catalog_no
      t.string   :lot_no
      t.string   :manufacturer
      t.string   :supplier
      t.decimal  :ordered_amount
      t.date     :ordered_date
      t.date     :last_date_updated
      t.string   :status
      t.timestamps
    end
  end
end
