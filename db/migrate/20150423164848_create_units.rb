class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string  :unit_name
      t.string  :unit_symbol
      t.string  :unit_type #KIT, SOLID, LIQUID
      t.timestamps
    end
  end
end
