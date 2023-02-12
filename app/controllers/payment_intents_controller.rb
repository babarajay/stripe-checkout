class PaymentIntentsController < ApplicationController
  def create
    # Create a payment intent with the expected amount,
    plan = Plan.find_by(id: params[:plan_id])
    payment_intent = Stripe::PaymentIntent.create(
      amount: (plan.price * 100).to_i,
      currency: 'usd',
      description: "Order for #{plan.name}",
      statement_descriptor: 'Submit plan',
    )

    # return the client secret
    render json: {
      id: payment_intent.id,
      client_secret: payment_intent.client_secret
    }
  end
end
