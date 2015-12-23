class ReportEmailer < ActionMailer::Base

  default from: ENV_EPA_EMAIL

  def send_report_uploaded_email(shopper_report)
    @shopper_report = shopper_report
    mail to: ENV_EMAIL_LIST, subject: 'Shopper Report Uploaded'
  end

end