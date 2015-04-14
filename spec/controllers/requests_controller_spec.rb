require 'spec_helper'

RSpec.describe RequestsController, type: :controller do

  context 'When viewing all requests' do
    it 'has status 200' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'assigns @requests object' do
      get :index
      expect(response).to assigns(:requests)
    end
  end

end
