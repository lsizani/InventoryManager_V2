class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.string  :changed_by
      t.string  :approved_by
      t.text    :reason_for_change
      t.date    :date_changed
      t.date    :date_approved
      t.integer :order_id
      t.integer   :request_id
      t.integer   :reagent_id
      t.integer   :kit_item_id
      t.integer   :log_id
      t.timestamps
    end
  end
end
