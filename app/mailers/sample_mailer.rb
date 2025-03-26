class SampleMailer < ApplicationMailer
  default from: "hogehoge@example.com"

  def welcome
    @user_name = "佐藤"
    mail(to: "fugafuga@example.com", subject: "subject です")
  end
end
