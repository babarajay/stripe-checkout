class Order < ApplicationRecord
  enum status: { pending: 0, failed: 1, paid: 2 }
  belongs_to :plan
  belongs_to :user
end
