require 'spec_helper'


RSpec.describe ReagentsController, type: :controller do
  context 'When opening reagents home' do
    it 'has status 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
