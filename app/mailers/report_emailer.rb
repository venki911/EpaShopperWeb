class ReportEmailer < ActionMailer::Base

  default from: 'epashopperapp@gmail.com' #ENV['EPA_EMAIL']

  def send_report_uploaded_email(shopper_report)
    @shopper_report = shopper_report
    mail to: 'calories3500@hotmail.com, epashopperapp@gmail.com', subject: 'Shopper Report Uploaded'
  end

end