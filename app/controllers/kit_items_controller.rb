class KitItemsController < ApplicationController

  def index
    @reagent = Reagent.find(params[:reagent_id])
    @items = KitItem.where("reagent_id=" + params[:reagent_id])
  end

  def new
    @reagent = Reagent.find(params[:reagent_id])
    @items = KitItem.where("reagent_id=" + params[:reagent_id])

  end

  def create
    @kit_item = KitItem.new(create_args)
    if @kit_item.save
      update_now(@kit_item, params[:reagent_id])
      redirect_to :controller => 'kit_items', :action => 'new', :reagent_id => params[:reagent_id]
    end

  end


  private
  def create_args
    params.require(:kit_item).permit(:item_name, :item_lot_no, :item_cat_no, :item_expiration_date, :item_storage_temp,
                                     :item_storage_location )
  end

  private
  def update_now(kit_item, reagent_id)
    ki = KitItem.find(kit_item.id)
    ki.update(reagent_id: reagent_id)
  end
end
