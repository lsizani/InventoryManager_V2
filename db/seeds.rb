# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
OrderNumberCount.create(order_number: 7700)
Study.create(study_name: 'General', study_number: 'GEN123454', study_start_date: Date.today, study_end_date: Date.new(2020, 1, 1))
Study.create(study_name: 'Parexel', study_number: 'PXL123454', study_start_date: Date.today, study_end_date: Date.new(2020, 1, 1))
Study.create(study_name: 'GSK', study_number: 'GSK123454', study_start_date: Date.today, study_end_date: Date.new(2020, 1, 1))