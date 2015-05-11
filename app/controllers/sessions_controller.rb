class SessionsController < ApplicationController
  #require 'sessions_helper'
  def new

  end

  def create
    begin

      user = ActiveDirectoryUser.authenticate(params[:ad_user][:user_name], params[:ad_user][:password])
      if user != nil
        # Log the user in and redirect to the user's show page.
        log_in(user)
        render 'welcome/index'
      else
        # Create an error message.
        flash[:danger] = 'Invalid user name/password combination' # Not quite right!
        redirect_to root_path
      end

    rescue Net::LDAP::Error => e
      logger.error('Message for the log file' + e.message)
      flash[:no_connection] = 'Error communicating with server, please try again later'
      redirect_to root_path
    end

  end

  def destroy
    log_out
    redirect_to root_path
  end
end
