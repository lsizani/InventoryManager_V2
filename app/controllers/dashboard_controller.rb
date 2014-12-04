class DashboardController < ApplicationController
  def index
     @studies = Study.all
  end

end
