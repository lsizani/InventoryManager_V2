module ImportsHelper
  require 'roo'
  UPLOAD_DIR = '/home/lsizani/dev/uploads/'

  def make_file(params)
    uploaded_io = params[:spreadsheet]
    File.open(UPLOAD_DIR + uploaded_io.original_filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    uploaded_io.original_filename
  end

  def open_wb(book_name)
    @book ||= Roo::Spreadsheet.open(book_name)
  end

  def get_sheets(book)
    @file = Roo::Spreadsheet.open(book)
  end

  def get_last_index(sheet)
    if sheet.last_row > 100
      i = 4
      while true do
        if sheet.row(i)[3].blank?
          return i - 1
        else
          i = i + 1
        end
      end
    else
      50
    end
  end

  def import_data_from_sheet(sheet, sheet_name)
    (4.. get_last_index(sheet)).each do |i|
      row = sheet.row(i)
      save_order_data_on_row(row, sheet_name)
    end
  end

  def save_order_data_on_row(row, sheet_name)
    order_num = row[12].to_i.to_s
    order = Order.find_by_order_no(order_num)
    if order.nil?
      order = Order.new(order_no: order_num, supplier: row[13], on_back_order:false, ordered_date: row[14], status:'Delivered')
      if order.save!
        import_request_data_on_row(row, order.id, sheet_name)
      end
    else
      import_request_data_on_row(row, order.id, sheet_name)
    end

  end

  def import_request_data_on_row(row, order_id, sheet_name)
    if row[1].nil? or row[1].blank?
      requested_by = 'Import User'
    else
      requested_by = row[1]
    end

    if row[2].nil? or row[2].blank?
      requested_amt = 999
    else
      requested_amt = row[2]
    end
    request = Request.new(reagent_name: row[3], requested_by: requested_by,
                          requested_for_study: sheet_name, requested_amount: requested_amt,
                          requested_date: nil, status: 'Delivered', last_update_date: Date.today,
                          ordered_amount: row[15], catalog_no: row[5], manufacturer: [4], supplier:[13],
                          is_reagent_kit: true, order_id: order_id, unit_price: 0
    )
    if request.save!
      save_reagent_data_on_row(row, request.id)
    end
  end

  def save_reagent_data_on_row(row, request_id)
    if row[7].blank? or row[7].nil? or not row[7].kind_of?Date
      exp_date = Date.new(2099, 1, 1)
    else
      exp_date = row[7]
    end
    if row[10].nil? or row[10].blank? or not row[10].kind_of?Numeric
      del_amount = 999
    else
      del_amount = row[10]
    end
    reagent = Reagent.new(request_id: request_id, delivered_amount: del_amount, item_lot_no: row[6].to_i.to_s, item_cat_no:
            row[5].to_i.to_s,storage_temp_kit: 0, storage_location: 'Imported', amount_left: 999,expiration_date: exp_date,
            status: 'Delivered'
    )

    if reagent.save!
    end
  end

end
