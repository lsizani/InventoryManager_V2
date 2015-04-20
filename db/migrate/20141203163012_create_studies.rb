class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string      :study_name
      t.string      :study_number
      t.date        :study_start_date
      t.date        :study_end_date

      #Audit data
      t.string      :last_changed_by
      t.string      :date_last_changed
      t.timestamps
    end
  end
end
