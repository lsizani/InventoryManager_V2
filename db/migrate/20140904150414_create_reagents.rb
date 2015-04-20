class CreateReagents < ActiveRecord::Migration
  def change
    create_table :reagents do |t|

      t.integer   :order_id
      t.decimal   :delivered_amount
      t.string    :item_lot_no
      t.string    :item_cat_no
      t.string    :storage_temp_kit
      t.string    :storage_location
      t.decimal   :amount_left
      t.date      :received_date
      t.date      :expiration_date
      t.string    :status
      t.date      :last_date_updated

      #Audit data
      t.string      :last_changed_by
      t.string      :date_last_changed
      t.timestamps
    end
  end
end
