class RequestsController < ApplicationController

  def index
    if current_user != nil
       @requests = Request.all
       if params[:order].blank?
         @requests = @requests.all
       else
         @requests = @requests.order(params[:order])
       end
    else
      redirect_to root_path
    end
  end

  def new
    if current_user != nil
      @request = Request.new
    else
      redirect_to root_path
    end

  end

  def create
    @request = Request.new(request_args)

    if @request.save
      update_now(@request)
      begin
        NoticeMailer.notify_new_request(@request).deliver
      rescue Exception => e
          logger.error("Message for the log file #{e.message}")
      end

      redirect_to :controller => 'requests', :action =>   'show', :id => @request.id
    else
      render :controller => 'requests', :action => 'new'
    end
  end

  def show
    if current_user != nil
      @request = Request.find(params[:id])
    else
      redirect_to root_path
    end

  end

  def update
    @request = Request.find(params[:id])

    if @request.update(request_args)
        update_now(@request)
        redirect_to :controller => 'requests', :action =>   'show', :id => @request.id
    else
      redirect_to :controller => 'requests', :action =>   'edit', :id => @request.id
    end
  end

  def edit
    if current_user != nil
      @request = Request.find(params[:id])
    else
      redirect_to root_path
    end
  end


  private
  def request_args
     params.require(:request).permit(:requested_by, :requested_date, :reagent_name, :requested_amount, :requested_for_study,
                                     :catalog_no, :manufacturer, :supplier, :is_reagent_kit)
  end


  private
  def update_now(record)
    re = Request.find_by(id: record.id)
    re.update(last_update_date:Date.today,date_last_changed:Date.today,
              last_changed_by: current_user_full_name, status:'Requested')
  end
end
