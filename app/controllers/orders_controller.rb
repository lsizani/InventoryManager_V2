class OrdersController < ApplicationController

  def index

     @orders = Order.all
     @requests = Request.where("status='Ordered'")

  end

  def new
     @request = Request.find_by(id: params[:id])

  end

  def edit

    @request = Request.find_by(id: params[:id])
    redirect_to :controller => 'orders', :action => 'new', :id => @request.id
  end

  def create
    @order = Order.new(create_params)
    if @order.save
      update_now(@order, params[:request_id])
    end
    redirect_to @order
  end

  def show
    @order = Order.find_by(id:params[:id])
  end

  private
  def create_params
      params.require(:order).permit(:lot_no, :order_no, :catalog_no, :manufacturer, :supplier, :ordered_date, :ordered_amount)
  end

  #
  # This function updates the order record, the field order.request_id is set and the status is changed to ordered
  # The status of the request is also changed to ordered
  #
  private
  def update_now(record, request_id)
    re = Order.find_by(id: record.id)
    re.update(request_id:request_id,last_date_updated:Date.today, status:'Ordered')

    re = Request.find_by(id: request_id)
    re.update(last_update_date:Date.today, status:'Ordered')
  end
end
