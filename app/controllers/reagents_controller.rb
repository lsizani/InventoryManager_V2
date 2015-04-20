class ReagentsController < ApplicationController
  def index
    if current_user != nil
      @reagents = Reagent.all
    else
      redirect_to root_path
    end

  end

  def dump_to_csv
    @reagents = Reagent.all
    respond_to do |format|
      format.csv { send_data @reagents.to_csv }
    end
  end

  def new
    if current_user != nil
      @id = params[:id]
      @order = Order.find(@id)
      @reagent = Reagent.new
    else
      redirect_to root_path
    end

  end

  def create
    @order = Order.find(params[:order_id])

    @reagent = Reagent.new(create_params)
    if @reagent.save

      @reagent.update_now(@reagent)
      if@order.request_is_reagent_kit

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
      code = make_code(@reagent.order, @reagent.order.request)
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
                                    :storage_location, :delivered_amount, :po_order_no, :is_reagent_kit)

  end

  private
  def make_code(order, request)
      "Request ID: #{request.id} Order ID: #{order.id}"
  end
end
