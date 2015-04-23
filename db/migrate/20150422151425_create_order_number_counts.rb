class CreateOrderNumberCounts < ActiveRecord::Migration
  def change
    create_table :order_number_counts do |t|
      t.integer   :order_number
      t.timestamps
    end
  end
end
