unless Plan.any?
  Plan.create(
    name: "Basic",
    stripe_plan_name: "basic",
    price: 100.0
  )
end
