require 'spec_helper'

RSpec.describe RequestsController, type: :controller do

  context 'When viewing all requests' do
    before :each do
      @lunga = ADUser.new('Test','User','TUser@synexagroup.com')
      log_in(@lunga)
    end

    it 'has status 200' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'assigns @requests object' do
     
    end
  end

end
