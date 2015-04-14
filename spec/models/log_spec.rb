require 'rails_helper'

RSpec.describe Log, :type => :model do
  context 'when creating a new log' do
    it 'raises an error when saving it without a study number' do
      log = Log.new(for_study: nil, opened_by: 'Lunga', opened_date: Date.today, number: 1)
      expect {log.save!}.to raise_error
    end

    it 'raises an error when saving it without specifying opened by' do
      log = Log.new(for_study: '123456', opened_by: nil, opened_date: Date.today, number: 1)
      expect {log.save!}.to raise_error
    end

    it 'raises an error when saving it without an opened date' do
      log = Log.new(for_study: '123456', opened_by: 'Lunga', opened_date: nil, number: 1)
      expect {log.save!}.to raise_error
    end

    it 'raises an error when saving it without specifying number of items used' do
      log = Log.new(for_study: '123456', opened_by: 'Lunga', opened_date: Date.today, number: nil)
      expect {log.save!}.to raise_error
    end
  end
end
