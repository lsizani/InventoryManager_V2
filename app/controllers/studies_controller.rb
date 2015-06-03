class StudiesController < ApplicationController

  def index
    @studies = Study.all
  end

  def new
    @study = Study.new
  end

  def create
    @study = Study.new(study_args)
    if @study.save
      redirect_to :controller => 'studies', :action =>   'index'
    end
  end

  def update
    @study = Study.find(params[:id])

    if @study.update(study_args)
      redirect_to :controller => 'studies', :action =>   'show', :id => @study.id
    else
      redirect_to :controller => 'studies', :action =>   'edit', :id => @study.id
    end
  end

  def edit
    @study = Study.find(params[:id])
  end

	def show
    @study = Study.find(params[:id])
	end

  private
  def study_args
      params.require(:study).permit(:study_name, :study_number, :study_start_date, :study_end_date)
  end
end
