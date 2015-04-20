class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer  :request_id
      t.string   :order_no
      t.string   :catalog_no
      t.decimal  :unit_price
      t.string   :manufacturer
      t.string   :supplier
      t.decimal  :ordered_amount
      t.boolean  :on_back_order
      t.decimal  :back_order_amount, :default => 0
      t.decimal  :back_order_delivery_date
      t.date     :ordered_date
      t.date     :last_date_updated
      t.string   :status

      #Audit data
      t.string      :last_changed_by
      t.string      :date_last_changed
      t.timestamps
    end

  end
end
