class NoticeMailer < ActionMailer::Base
  default from: "lsizani@synexagroup.com"


  def notify_new_request(request)
      @request = request
      @url = "http://127.0.0.1:3000/requests"
      mail(to: 'lsizani@synexagroup.com', subject: 'New Reagent Request')
  end

end
