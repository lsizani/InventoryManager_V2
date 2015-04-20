class ReportsController < ApplicationController
  caches_page :show

  def index
    if current_user != nil
    else
      redirect_to root_path
    end
  end

  def show
    if current_user != nil
      id = params[:id]
      tables = params[:selection].to_a

      @object = ReportObject.new
      @object.assign(id, tables)
    else
      redirect_to root_path
    end

  end

  def create
    redirect_to :controller => 'reports',
                :action => 'show', :id => params[:study][:id], :selection => params[:table][:selection]
  end

  def study_cost

  end
end
