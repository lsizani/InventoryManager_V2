class ReportsController < ApplicationController
  def index
    args = params[:goto]

    case args
      when 'manifest'
        if params[:manifest] != nil
          @report = 'report'
          id = params[:manifest][:id] != nil ? params[:manifest][:id] : 0
          @object = ReportObject.new

          @object.assign(id)
          #@sum = @object.order_cost(@object.orders)
        else
          @report = 'placeholder'
        end
        @template = 'manifest'
      when 'options'
        @template = 'options'
      else
        @template = 'options'
    end



  end

  def show

  end

  def study_cost

  end
end
