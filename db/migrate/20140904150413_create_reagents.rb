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

      #the following fields are for a kit reagent i.e not a single item
      t.boolean   :is_reagent_kit
      t.integer   :child_items_no
      t.timestamps
    end
  end
end
