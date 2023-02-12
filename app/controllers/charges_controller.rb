class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception

  def create
    order = Order.new(charges_params)
    order.user_id = current_user.id
    order.status = :paid
    if order.save
      redirect_to success_path
    else
      flash.now[:error] = "Oops, something went wrong with your submission. Please try again!"
      redirect_to root_path
    end
  end

  private

  def charges_params
    params.permit(:plan_id, :stripe_payment_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
