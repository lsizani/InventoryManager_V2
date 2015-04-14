require 'rails_helper'

RSpec.describe Request, type: :model do
  context 'when creating a new request' do
    it 'raises an error when saving it without a requesting user name' do
      request = Request.new(requested_by: nil, reagent_name: 'Awesome reagent', requested_amount: 2, requested_for_study: 'general')
      expect {request.save!}.to raise_error
    end

    it 'raises an error when saving it without a reagent name' do
      request = Request.new(requested_by: 'The Creator', reagent_name: nil, requested_amount: 2, requested_for_study: 'general')
      expect {request.save!}.to raise_error
    end

    it 'raises an error when saving it without a requested amount' do
      request = Request.new(requested_by: 'The Creator', reagent_name: 'Test reagent 2', requested_amount: nil, requested_for_study: 'general')
      expect {request.save!}.to raise_error
    end

    it 'raises an error when saving it without a study number' do
      request = Request.new(requested_by: 'The Creator', reagent_name: 'Test reagent 3', requested_amount: 2, requested_for_study: nil)
      expect {request.save!}.to raise_error
    end
  end
end
