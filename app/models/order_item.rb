class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product


  enum production_status:{ cant: 0,waiting: 1, working: 2, completed: 3 }
end