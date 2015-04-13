require 'spec_helper'

RSpec.describe RequestsController, :type => :controller do


  describe 'GET index' do
    it 'assigns @requests' do
      get :index
      expect(assigns(:requests))
    end

    it 'gets index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'Get new' do
    it 'assigns @studies' do
      get :new
      expect(assigns(:studies))
    end

    it 'creates a request object' do
      get :new
      expect(:request).to a_kind_of Request
    end
  end


end
