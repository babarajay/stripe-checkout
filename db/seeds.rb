unless Plan.any?
  [["Basic", 100.0], ["Premium", 200.0], ["Pro", 300.0]].each do |plan|
    Plan.create(
      name: plan[0],
      stripe_plan_name: plan[0].downcase,
      price: plan[1]
    )
  end
end
