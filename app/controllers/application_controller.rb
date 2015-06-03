class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  UPLOAD_DIR = '/home/lsizani/dev/uploads/'
  include SessionsHelper
  include ImportsHelper

  before_action :require_login, :add_audit, only: [:update]

  private
  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to root_url # halts request cycle
    end
  end

  private
  def add_audit
    redirect_to :controller => 'audits', :action => 'new', :data => params
  end

end
