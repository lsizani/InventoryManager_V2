class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string  :reagent_name
      t.string  :requested_by
      t.string  :requested_for_study
      t.decimal :requested_amount
      t.date    :requested_date
      t.string  :status
      t.date    :last_update_date

      #optional fields to aid in order
      t.string :catalog_no
      t.string :manufacturer
      t.string :supplier

      t.timestamps
    end
  end
end
