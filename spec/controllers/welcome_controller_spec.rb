require '../../spec/rails_helper'


RSpec.describe WelcomeController, :type => :controller do
  describe "GET index" do
    it "gets welcome template" do
      get 'index'
      expect(response).to render_template("index")
    end
  end

end
