class OrderUMailer < ApplicationMailer

  default from: 'from@example.com'
  layout 'mailer'

  def you_order_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Ваш Заказ')
  end

end
