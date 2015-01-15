class ReportObject

  def assign(study_id)
    @id = study_id
  end

  def assign(study_id, tables)
    @id = study_id
    @show_tables = tables
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

  def show_tables
    @show_tables
  end

end