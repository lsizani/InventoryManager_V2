class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :kit_items, :reagent_id
    add_index :logs,  :reagent_id
    add_index :reagents, :request_id
    add_index :requests, :order_id
    add_index :requests, :reagent_id
  end
end
