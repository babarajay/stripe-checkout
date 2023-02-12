Product.destroy_all
10.times do
Product.create([{
  title: Faker::Commerce.product_name[0..20],
  description: Faker::Lorem.sentence(word_count: 15),
  unit_amount: Faker::Commerce.price(range: 1000..10000.0, as_string: true),
  image_url: "https://picsum.photos/200/300",
}])
end

puts "#{Product.count} products"
