class StripeCharges
  DEFAULT_CURRENCY = 'usd'.freeze

  def initialize(params, user)
    @stripe_token = params[:stripeToken]
    @plan = Plan.find_by(id: params[:plan_id])
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_token, :plan

  def find_customer
    if user.stripe_token
      retrieve_customer(user.stripe_token)
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
      email: user.email,
      source: stripe_token
    )
    user.update(stripe_token: customer.id)
    customer
  end

  def create_charge(customer)
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: (@plan.price * 100).to_i, # converting price to cents
      description: customer.email,
      currency: DEFAULT_CURRENCY
    )

    create_order(charge.id)
  end

  def create_order(charge_id)
    Order.create(
      plan_id: plan.id,
      user_id: user.id,
      status: 2,
      token: stripe_token,
      charge_id: charge_id
    )
  end
end