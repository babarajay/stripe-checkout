class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :plan_id
      t.integer :user_id
      t.integer :status
      t.string :token
      t.string :charge_id
      t.string :error_message
      t.string :customer_id

      t.timestamps
    end
  end
end
