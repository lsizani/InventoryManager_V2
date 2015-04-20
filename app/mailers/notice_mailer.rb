class NoticeMailer < ActionMailer::Base
  default from: 'inventory@synexagroup.com'

  def notify_new_request(request)
      @request = request
      @url = 'http://127.0.0.1:3000/requests'
      mail(to: 'lsizani@synexagroup.com', subject: 'New Reagent Request')
  end

  def notify_new_order(order)
    @order = order
    @url = 'http://127.0.0.1:3000/orders'
    mail(to: 'lsizani@synexagroup.com', subject: 'An order has been completed')
  end

end
