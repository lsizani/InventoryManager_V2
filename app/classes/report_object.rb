class ReportObject

  def assign(study_id)
    @id = study_id
  end

  def study
    @study = Study.find(@id)
  end

  def requests
    @requests = Request.where(requested_for_study: @study.study_name)
  end

  def orders
    rids = requests
    ids = rids.collect {|s| s.id}
    @orders = Order.where(request_id: ids)
  end

  def order_cost
    prices=  @orders.collect { |o| o.unit_price * o.ordered_amount }
    @sum = 0
    prices.each { |c| @sum += c }
    @sum
  end

end