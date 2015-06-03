class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:login, :index]

  def login

  end

  def index
    @user = current_user
    render 'welcome/index'
  end

end
