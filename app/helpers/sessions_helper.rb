module SessionsHelper
  def log_in(user)

    online_user = OnlineUser.new(first_name: user.first_name, last_name: user.last_name, email: user.email)
    if online_user.save
      session[:user_id] = online_user.id
    end

  end

  def current_user
    @current_user ||= OnlineUser.find_by(id: session[:user_id])
  end

  def log_out
    OnlineUser.delete(session[:user_id])
    session.delete(:user_id)
    @current_user = nil

    if OnlineUser.count < 1
      #TODO: reset id
      ActiveRecord::Base.connection.reset_pk_sequence!('online_users')
    end

  end
end
