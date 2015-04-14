class WelcomeController < ApplicationController
  def login

  end

  def index
    if current_user != nil
      @user = current_user
      render 'welcome/index'
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      redirect_to root_path
    end
  end

end
