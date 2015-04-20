module SessionsHelper
  def log_in(user)
    groups = user.user_groups, Proc.new{|g|  g.gosub("\" ") }
    online_user = OnlineUser.new(first_name: user.first_name,
                                 last_name: user.last_name, email: user.email, groups: user.user_groups)
    if online_user.save
      session[:user_id] = online_user.id
    end

  end

  def current_user
    @current_user ||= OnlineUser.find_by(id: session[:user_id])
  end

  def current_user_full_name
    @name = current_user.first_name.concat(' '.concat(current_user.last_name))
  end

  def log_out
    OnlineUser.delete(session[:user_id])
    session.delete(:user_id)
    @current_user = nil
  end
end
