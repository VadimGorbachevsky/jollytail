class RegistrationsController < Devise::RegistrationsController

  def after_inactive_sign_up_path_for (resource)
    @cart = Cart.new
    @cart.user_id = resource.id
    @cart.save
    resource.cart_id = @cart.id
    resource.save
    root_url
  end

end
