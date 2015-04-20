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
    if current_user != nil
      @study = Study.find(params[:id])
    else
      redirect_to root_path
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
  def study_args
      params.require(:study).permit(:study_name, :study_number, :study_start_date, :study_end_date)
  end
end
