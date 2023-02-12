class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception

  def create
    StripeCharges.new(charges_params, current_user).call
    redirect_to success_path
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :plan_id, :stripeTokenType)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
