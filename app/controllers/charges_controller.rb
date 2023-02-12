class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception

  def new
    checkout_session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: 'T-shirt',
        description: 'Comfortable cotton t-shirt',
        images: ['https://example.com/t-shirt.jpg'],
        amount: 500,
        currency: 'usd',
        quantity: 1,
      }],
      success_url: success_url,
      cancel_url: success_url,
      customer_email: 'customer@example.com',
      billing_address_collection: 'required',
      payment_intent_data: {
        setup_future_usage: 'off_session',
        metadata: {
          integration_check: 'accept_a_payment',
        },
      },
      use_stripe_sdk: true,
      three_d_secure: {
        card: 'required',
      },
    })

    render json: { id: checkout_session.id }
  end

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
