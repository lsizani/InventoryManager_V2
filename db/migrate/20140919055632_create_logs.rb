class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer   :reagent_id
      t.integer   :number
      t.string    :item_lot_no
      t.date      :received_date
      t.date      :expiration_date
      t.date      :opened_date
      t.string    :opened_by
      t.string    :for_study

      #Audit data
      t.string      :last_changed_by
      t.string      :date_last_changed
      t.timestamps
    end
  end
end
