class StudiesController < ApplicationController

  def index
    @studies = Study.all
  end

  def new
      @study = Study.new
  end

  def create
    @study = Study.new(create_params)
    if @study.save
      redirect_to :controller => 'studies', :action =>   'show', :id => @study.id
    end
  end

	def show
		@study = Study.find(params[:id])
	end

  private
  def create_params
      params.require(:study).permit(:study_name, :study_number, :study_start_date, :study_end_date)
  end
end
