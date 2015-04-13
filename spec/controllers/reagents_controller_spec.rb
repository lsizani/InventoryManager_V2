require 'spec_helper'

RSpec.describe ReagentsController, :type => :controller do
    describe 'GET index' do
      it 'gets index template' do
        get :index
        expect(response).to render_template("index")
      end
    end

end
