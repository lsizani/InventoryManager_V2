class ReportsController < ApplicationController
  caches_page :show

  def index

  end

  def show
    id = params[:id]
    tables = params[:selection].to_a

    @object = ReportObject.new
    @object.assign(id, tables)

  end

  def create
    redirect_to :controller => 'reports',
                :action => 'show', :id => params[:manifest][:id], :selection => params[:table][:selection]
  end

  def study_cost

  end
end
