class OrderUsMailer < ApplicationMailer

  default from: 'from@example.com'
  layout 'mailer'

  def us_order_email
    @user = params[:user]
    @order = params[:order]
    mail(to: "shaersorrel@gmail.com", subject: "Заказ № #{@order.id}")
  end

end
