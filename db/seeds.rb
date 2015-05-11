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

Units.create(unit_type:'KIT', unit_name:'boxes/packs', unit_symbol:'boxes/packs')

Units.create(unit_type:'LIQUID', unit_name:'litres', unit_symbol:'l')
Units.create(unit_type:'LIQUID', unit_name:'milliliters', unit_symbol:'ml')
Units.create(unit_type:'LIQUID', unit_name:'microliters', unit_symbol:'ul')

Units.create(unit_type:'SOLID', unit_name:'kilograms', unit_symbol:'kg')
Units.create(unit_type:'SOLID', unit_name:'grams', unit_symbol:'g')
Units.create(unit_type:'SOLID', unit_name:'milligrams', unit_symbol:'mg')
Units.create(unit_type:'SOLID', unit_name:'micrograms', unit_symbol:'ug')

