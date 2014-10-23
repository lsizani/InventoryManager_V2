class CreateKitItems < ActiveRecord::Migration
  def change
    create_table :kit_items do |t|
      t.integer  :reagent_id
      t.string   :item_name
      t.string   :item_lot_no
      t.string   :item_cat_no
      t.date     :item_expiration_date
      t.decimal  :item_storage_temp
      t.string   :item_storage_location
      t.date     :last_date_updated

      #the following fields are for the reagent log sheet
      t.boolean  :is_item_used, :default => false   #must default to false
      t.date     :date_opened
      t.string   :used_by
      t.timestamps
    end
  end
end
