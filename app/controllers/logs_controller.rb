class LogsController < ApplicationController

  def index
    @reagent_id =  params[:reagent_id]
    @reagent = Reagent.find(@reagent_id)
    @log = Log.where("reagent_id=" + params[:reagent_id])

  end

  def new
    @reagent = Reagent.find(params[:reagent_id])
  end

  def create
     @log = Log.new(create_args)
     if @log.save
       update_now(@log, params[:reagent_id])
       redirect_to :controller => 'logs', :action => 'index', :reagent_id => params[:reagent_id]
     end
  end

  private
  def create_args
    params.require(:log).permit(:item_lot_no, :number, :received_date, :expiration_date, :opened_date, :opened_by, :for_study)
  end

  private
  def update_now(record, reagent_id)
    log = Log.find(record.id)
    log.update(reagent_id:reagent_id)

    re = Reagent.find(reagent_id)
    amount = re.amount_left - log.number
    if amount > 1
      re.update(amount_left: amount)

    else
      re.update(status='Depleted')
    end

  end

end
