require 'rails_helper'

RSpec.describe KitItem, :type => :model do
  context 'when creating a new kit item' do
    it 'raises an error when saving it without an expiration date' do
      ki = KitItem.new(item_expiration_date: nil, item_name: 'Kit Item Name', item_storage_location: 'Walk in Freezer')
      expect {ki.save!}.to raise_error
    end

    it 'raises an error when saving it without a kit item name' do
      ki = KitItem.new(item_expiration_date: Date.tomorrow, item_name: nil, item_storage_location: 'Walk in Freezer')
      expect {ki.save!}.to raise_error
    end

    it 'raises an error when saving it without a location' do
      ki = KitItem.new(item_expiration_date: Date.tomorrow, item_name: 'Kit Item Name', item_storage_location: nil)
      expect {ki.save!}.to raise_error
    end
  end
end
