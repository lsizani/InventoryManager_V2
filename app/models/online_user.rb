class OnlineUser < ActiveRecord::Base
  serialize :groups
end
