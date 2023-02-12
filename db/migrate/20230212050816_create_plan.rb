class CreatePlan < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name, limit: 50
      t.string :stripe_plan_name, limit: 50
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end