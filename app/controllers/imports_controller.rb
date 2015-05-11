class ImportsController < ApplicationController

  def index

  end

  def upload
    fname = make_file(params)
    if fname != 'Invalid_Extension'
      @file = get_sheets(UPLOAD_DIR + fname)
      @filename = fname
    else
      redirect_to 'imports/index'
    end
  end

  def process_file
    @xlsx = open_wb(UPLOAD_DIR + params[:data][:fname])
    @fname = params[:data][:fname]
    keepers = params[:data].keep_if{ |_, value|  '1'.include?value  }
    @data = keepers.keys

    @data.each do |sh|
      sheet = @xlsx.sheet(sh)
      import_data_from_sheet(sheet, sh)
    end
  end

end
