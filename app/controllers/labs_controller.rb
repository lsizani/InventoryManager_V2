class LabsController < ApplicationController
  def index
    @labs = Labs.all
  end

  def new
    @lab = Labs.new
  end

  def create
    @lab = Labs.create(lab_params)
    if @lab.save!
      redirect_to :controller => 'labs', :action => 'index'
    else
      redirect_to :controller => 'labs', :action => 'new'
    end
  end


  def destroy
    @lab = Labs.find(params[:id])
    @lab.destroy
    redirect_to :controller => 'labs', :action => 'index'
  end

  private
  def lab_params
    params.require(:lab).permit(:name)
  end
  
end
