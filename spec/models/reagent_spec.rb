require 'rails_helper'

RSpec.describe Reagent, :type => :model do
  context 'when creating a new reagent' do
    it 'raises an error when saving it without an item lot number' do
      reagent = Reagent.new(item_lot_no: nil, expiration_date: Date.today, delivered_amount: 4, storage_location: 'That location')
      expect {reagent.save!}.to raise_error
    end

    it 'raises an error when saving it without an expiration date' do
      reagent = Reagent.new(item_lot_no: 12234, expiration_date: nil, delivered_amount: 4, storage_location: 'That location')
      expect {reagent.save!}.to raise_error
    end

    context 'when creating a new request' do
      it 'raises an error when saving it without a delivered amount' do
        reagent = Reagent.new(item_lot_no: 12234, expiration_date: Date.today, delivered_amount: nil, storage_location: 'That location')
        expect {reagent.save!}.to raise_error
      end

      it 'raises an error when saving it without a location' do
        reagent = Reagent.new(item_lot_no: 12234, expiration_date: Date.today, delivered_amount: 4, storage_location: nil)
        expect {reagent.save!}.to raise_error
      end
    end
  end
end
