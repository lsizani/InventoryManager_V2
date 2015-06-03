class AuditsController < ApplicationController

  def new
    @parent_data = params[:data]
    @audit = Audit.new
  end

  def create

  end

  private
  def audit_args
    params.require(:audit).permit!
  end
end
