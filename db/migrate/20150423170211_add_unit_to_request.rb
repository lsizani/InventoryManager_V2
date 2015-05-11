class AddUnitToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :units, :string
  end
end
