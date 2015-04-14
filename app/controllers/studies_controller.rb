class StudiesController < ApplicationController

  def index
    if current_user != nil
      @studies = Study.all
    else
      redirect_to root_path
    end

  end

  def new
    if current_user != nil
      @study = Study.new
    else
      redirect_to root_path
    end

  end

  def create
    @study = Study.new(create_params)
    if @study.save
      redirect_to :controller => 'studies', :action =>   'show', :id => @study.id
    end
  end

	def show
    if current_user != nil
      @study = Study.find(params[:id])
    else
      redirect_to root_path
    end

	end

  private
  def create_params
      params.require(:study).permit(:study_name, :study_number, :study_start_date, :study_end_date)
  end
end
