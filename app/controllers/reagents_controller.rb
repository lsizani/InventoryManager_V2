class ReagentsController < ApplicationController
  def index
    @reagents = make_collection

  end

  private
  def make_collection
    reagents = Reagent.all
    orders = Order.select('id, request_id').where(status:['Delivered', 'OBO'])
    requests = Request.select('id, reagent_name, is_reagent_kit').where(status:['Delivered', 'OBO'])
    collection = Array.new

    i = 0
    reagents.each { |r|
      orders.each{  |o|
        if r.order_id == o.id
          requests.each { |re|
            if re.id == o.request_id
              temp = ReagentObject.new
              temp.set_vars(r,o,re)
              collection[i] = temp
              i = i + 1
            end
          }
        end

      }
    }
    collection
  end

  def edit
    @order = Order.find(params[:id])
    @reagent = Reagent.find_by(order_id:@order.id)
    @request = Request.find(@order.request_id)
  end

  def update
     @reagent = Reagent.find(params[:id])
     @order = Order.find(params[:order_id])
     @request = Request.find(@order.request_id)

     if @reagent.update(create_params)
       update_now(@reagent, params[:order_id])
       redirect_to :controller => 'requests', :action =>   'show', :id => @request.id
     else
       redirect_to :controller => 'requests', :action =>   'edit', :id => @request.id
     end
  end

  def new
    @reagent = Reagent.new
    @order = Order.find(params[:order_id])
    @request = Request.find(@order.request_id)
  end

  def create
    @order = Order.find(params[:order_id])
    @request = Request.find(@order.request_id)

    @reagent = Reagent.new(create_params)
    if @reagent.save

      update_now(@reagent, params[:order_id])
      if@request.is_reagent_kit

        redirect_to :controller => 'kit_items' , :action => 'new', :reagent_id=> @reagent.id
      else
        redirect_to :controller => 'reagents' , :action => 'show', :id=> @reagent.id
      end
    else
      render :controller => 'reagents', :action => 'new', :order_id => params[:order_id]
    end

  end

  def show
      @reagent = Reagent.find(params[:id])
      @order = Order.find_by(id: @reagent.order_id)
      @request = Request.find_by(id: @order.request_id)

      code = make_code(@order, @request)
      @qr = RQRCode::QRCode.new( code, :size => 4, :level => :h )
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
  def update_now(reagent, order_id)
    re = Reagent.find(reagent.id)
    order = Order.find(order_id)
    request = Request.find(order.request_id)
    amount_left = 0
    bo_amount = 0
    bo_status = false
    status = ''

    #if order.on_back_order then we're editing a reagent
    if order.on_back_order
      #if we're here then this is to update a back ordered reagent
      #check if delivery amount <= requested amount:
      if order.back_order_amount <= reagent.delivered_amount
        #if all the requested quantity has been delivered
        amount_left = re.amount_left + reagent.delivered_amount
        status = 'Delivered'
     end
      if order.back_order_amount > reagent.delivered_amount
        amount_left = re.amount_left + reagent.delivered_amount
        status = 'OBO'
      end

    else
      if order.ordered_amount <= reagent.delivered_amount
        status = 'Delivered'
        bo_status = false
        bo_amount = 0
        amount_left = reagent.delivered_amount
      end
      if order.ordered_amount > reagent.delivered_amount
        status = 'OBO'
        bo_status = true
        bo_amount = order.ordered_amount - reagent.delivered_amount
        amount_left = reagent.delivered_amount
      end
    end

    re.update(order_id: order_id, amount_left: amount_left, last_date_updated: Date.today)
    order.update(on_back_order: bo_status, back_order_delivery_date: Date.today, back_order_amount: bo_amount, status: status)
    request.update(status:status)

  end

  private
  def make_code(order, request)
      "Request ID: #{request.id} Order ID: #{order.id}"
  end
end
