class ReagentsController < ApplicationController
  def index
     @reagents = Reagent.all
     @orders = Order.select('id, request_id').where("status='Delivered'")
     @requests = Request.select('id, reagent_name').where("status='Delivered'")
  end

  def edit
    redirect_to :controller => 'reagents' , :action => 'new', :id=> params[:id]
  end

  def new
    @order = Order.find(params[:id])
    @request = Request.find(@order.request_id)
  end

  def create
    @reagent = Reagent.new(create_params)
    if @reagent.save
      update_now(@reagent, params[:order_id])
      redirect_to :controller => 'reagents' , :action => 'show', :id=> @reagent.id
    end

  end

  def show
      @reagent = Reagent.find(params[:id])
      @order = Order.find_by(id: @reagent.order_id)
      @request = Request.find_by(id: @order.request_id)

      code = make_code(@reagent, @order, @request)
      @qr = RQRCode::QRCode.new( code, :size => 4, :level => :h )
  end

  private
  def create_params
    params.require(:reagent).permit(:received_date, :expiration_date, :item_lot_no, :item_cat_no, :storage_temp_kit,
                                    :storage_location, :delivered_amount, :po_order_no)

  end

  private
  def update_now(reagent, id)
    re = Reagent.find(reagent.id)
    re.update(order_id:id, last_date_updated:Date.today)

    order = Order.find(id)
    order.update(status:'Delivered')

    request = Request.find(order.request_id)
    request.update(status:'Delivered')
  end

  private
  def make_code(reagent, order, request)
    text = "Request ID: #{request.id} Order ID: #{order.id}"
    return text
  end
end
