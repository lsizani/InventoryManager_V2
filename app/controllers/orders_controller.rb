class OrdersController < ApplicationController

  def index
    if current_user != nil
      @orders = Order.all
      @requests = Request.where(status:['Ordered','OBO'])
    else
      redirect_to root_path
    end

  end

  def new
    if current_user != nil
     @request = Request.find_by(id: params[:id])
     @order = Order.new
    else
      redirect_to root_path
    end

  end

  def edit

    if current_user != nil
      @request = Request.find_by(id: params[:id])
      redirect_to :controller => 'orders', :action => 'new', :id => @request.id
    else
      redirect_to root_path
    end

  end


  def create
    @request = Request.find_by(id: params[:request_id])
    @order = Order.new(create_params)
    if @order.save
      update_now(@order, params[:request_id])
      redirect_to @order
    else
      render :controller => 'orders', :action => 'new', :id => @request.id
    end

  end

  def show
    if current_user != nil
      begin
        @order = Order.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
         @order = Order.find_by_request_id(params[:id])
      end
      @request = Request.find(@order.request_id)
    else
      redirect_to root_path
    end

  end

  private
  def create_params
      params.require(:order).permit(:lot_no, :order_no, :catalog_no, :manufacturer, :supplier, :ordered_date,
                                    :ordered_amount, :unit_price)
  end

  #
  # This function updates the order record, the field order.request_id is set and the status is changed to ordered
  # The status of the request is also changed to ordered
  #
  private
  def update_now(record, request_id)
    order = Order.find_by(id: record.id)
    order.update(request_id:request_id,last_date_updated:Date.today, status:'Ordered')

    re = Request.find_by(id: request_id)
    re.update(last_update_date:Date.today, status:'Ordered')

    if order.supplier.blank?
      order.update(supplier: re.supplier)
    end
    if order.manufacturer.blank?
      order.update(manufacturer: re.manufacturer)
    end
    if order.catalog_no.blank?
      order.update(catalog_no: re.catalog_no)
    end

  end
end
