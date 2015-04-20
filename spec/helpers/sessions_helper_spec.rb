require 'spec_helper'
require 'lib/ad_user'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe 'string concat' do
#     it 'concats two strings with spaces' do
#       expect(helper.concat_strings('this','that')).to eq('this that')
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do


  context 'When logging in' do
    before :each do
      @lunga = ADUser.new('Test','User','TUser@synexagroup.com', ['All Users','Synexa Cape Town', 'IT Support'])
      log_in(@lunga)
    end

    after :all do
      OnlineUser.delete_all
    end

    it 'add user to online_users table' do
      expect(OnlineUser.count).to eq(1)
    end

    it 'assigns user id to session[:user_id]' do
      expect(session[:user_id]).to eq(OnlineUser.last.id)
    end

    it 'assigns @current_user' do
      expect(current_user).kind_of? OnlineUser
      expect(current_user.first_name).to eq('Test')
      expect(current_user.last_name).to eq('User')
    end
  end

  context 'When logging out' do
    before :each do
      @lunga = ADUser.new('Test','User','TUser@synexagroup.com', ['All Users','Synexa Cape Town', 'IT Support'])
      log_in(@lunga)
    end

    it 'removes user_id from session' do
        log_out
        expect(session[:user_id]).to eq(nil)
    end

    it 'deletes user from online_users table' do
      log_out
      expect(OnlineUser.count).to eq(0)
    end

    it 'deletes @current_user' do
      log_out
      expect(current_user).to eq(nil)
    end
  end
end
