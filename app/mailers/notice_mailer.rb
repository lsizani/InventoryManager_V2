class NoticeMailer < ActionMailer::Base
  default from: 'inventory@synexagroup.com'
  def settings
    @settings = YAML::load_file Rails.root.join('config/config.yml')
  end

  def notify_new_request(request)
      email = settings
      @request = request
      @url = 'http://127.0.0.1:3000/requests'
      mail(to: email['request_recipients'], subject: 'New Reagent Request')
  end

  def notify_new_order(order)
    @order = order
    email = settings
    @url = 'http://127.0.0.1:3000/orders'
    mail(to: email['order_recipients'], subject: 'An order has been completed')
  end

end
