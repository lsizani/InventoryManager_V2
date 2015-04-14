require 'rails_helper'

RSpec.describe Study, :type => :model do
  context 'when creating a new study' do
    it 'raises an error when saving it without a study number' do
      study = Study.new(study_number: nil, study_start_date: Date.yesterday, study_end_date: Date.tomorrow)
      expect {study.save!}.to raise_error
    end

    it 'raises an error when saving it without a start date' do
      study = Study.new(study_number: '12345', study_start_date: nil, study_end_date: Date.tomorrow)
      expect {study.save!}.to raise_error
    end

    it 'raises an error when saving it without an end date' do
      study = Study.new(study_number: '12345', study_start_date: Date.yesterday, study_end_date: nil)
      expect {study.save!}.to raise_error
    end
  end
end
