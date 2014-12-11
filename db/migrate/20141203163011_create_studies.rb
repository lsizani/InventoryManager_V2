class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string      :study_name
      t.string      :study_number
      t.date        :study_start_date
      t.date        :study_end_date
      t.timestamps
    end
  end
end
