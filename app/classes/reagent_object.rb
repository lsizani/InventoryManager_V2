class ReagentObject


  def set_vars(rea, ord, req)
    @reagent = rea
    @order = ord
    @request = req
  end

  def request
    @request
  end

  def order
     @order
  end

  def reagent
     @reagent
  end

end