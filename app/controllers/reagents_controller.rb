class ReagentsController < ApplicationController
  def index
    if current_user != nil
      @reagents = Reagent.all
    else
      redirect_to root_path
    end

  end

  def new
    if current_user != nil
      @reagent = Reagent.new
      @request = Request.find(params[:id])
    else
      redirect_to root_path
    end

  end

  def create

    @reagent = Reagent.new(create_params)
    if @reagent.save
        @reagent.update_now
      if@reagent.request_is_reagent_kit
        redirect_to :controller => 'kit_items' , :action => 'new', :reagent_id=> @reagent.id
      else
        redirect_to :controller => 'reagents' , :action => 'show', :id=> @reagent.id
      end
    else
      render :controller => 'reagents', :action => 'new', :order_id => params[:order_id]
    end

  end

  def edit
    if current_user != nil
      @order = Order.find(params[:id])
      @reagent = Reagent.find_by(order_id:@order.id)
    else
      redirect_to root_path
    end

  end

  def update
     @reagent = Reagent.find(params[:id])
     if @reagent.update(create_params)
       redirect_to :controller => 'requests', :action =>   'show', :id => @reagent.order.request.id
     else
       redirect_to :controller => 'requests', :action =>   'edit', :id => @reagent.order.request.id
     end
  end

  def show
    if current_user != nil
      @reagent = Reagent.find(params[:id])
      code = make_code(@reagent)
      @qr = RQRCode::QRCode.new( code, :size => 4, :level => :h )
    else
      redirect_to root_path
    end

  end

  def show_reagent
    redirect_to :controller => 'reagents' , :action => 'show', :id=> params[:id]
  end

  private
  def create_params
    params.require(:reagent).permit(:received_date, :expiration_date, :item_lot_no, :item_cat_no, :storage_temp_kit,
                                    :storage_location, :delivered_amount, :request_id)

  end

  private
  def make_code(reagent)
      "Request ID: #{reagent.request_id} Order ID: #{reagent.request_order.id}"
  end
end
