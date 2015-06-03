class ReportsController < ApplicationController

  include ReagentsHelper

  def index
  end

  def show
    redirect_to index
  end

  def create
    date = Date.new(params[:reagents]['reagents (1i)'].to_i,
                    params[:reagents]['reagents (2i)'].to_i,
                    params[:reagents]['reagents (3i)'].to_i)
    @reagents = Reagent.on_or_before(date)

    respond_to do |format|
      format.csv { send_data @reagents.to_csv }
    end
  end
end
