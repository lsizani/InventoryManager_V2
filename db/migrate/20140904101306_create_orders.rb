class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string   :order_no
      t.string   :supplier
      t.boolean  :on_back_order
      t.date     :back_order_delivery_date
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
