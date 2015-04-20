require 'spec_helper'



RSpec.describe ReagentsController, type: :controller do
  context 'When opening reagents home' do

    before :each do
      @lunga = ADUser.new('Test','User','TUser@synexagroup.com', ['All Users','Synexa Cape Town', 'IT Support'])
      log_in(@lunga)
    end

    it 'has status 200' do
      get :index
      expect(response.status).to eq(200)
    end

  end
end
