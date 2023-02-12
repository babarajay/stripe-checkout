class Plan < ActiveRecord::Base
  has_many :orders
end
