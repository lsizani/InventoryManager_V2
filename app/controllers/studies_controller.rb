class StudiesController < ApplicationController

  def new
      @study = Study.new
  end

  def create
    @study = Study.new(create_params)
    if @study.save
      render :controller => 'dashboard', :action => 'index'
    end

  end

  private
  def create_params
      params.require(:study).permit(:study_name, :study_number, :study_start_date)
  end
end
