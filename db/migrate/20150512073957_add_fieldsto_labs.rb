class AddFieldstoLabs < ActiveRecord::Migration
  def change
    add_column :labs, :lab_manager, :string
  end
end
