require 'spec_helper'

RSpec.describe WelcomeController, type: :controller do

  context 'with valid user' do
    before :each do
      @lunga = ADUser.new('Test','User','TUser@synexagroup.com', ['All Users','Synexa Cape Town', 'IT Support'])
      log_in(@lunga)
    end

    after :each do
      log_out
    end

    it 'gets welcome template' do
      get 'index'
      expect(response).to render_template('index')
    end
  end

  context 'without a valid user' do

    it 'redirects to login page' do
        get 'index'
        expect(response.status).to eq(302)
    end
  end

end
