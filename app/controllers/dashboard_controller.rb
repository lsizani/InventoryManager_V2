class DashboardController < ApplicationController
  def index
     @studies = Request.select('id, requested_for_study')

  end
end
