class Order < ApplicationRecord
  belongs_to :member
  has_many :order_items, dependent: :destroy

  enum payment_method:{credit_card: 0, bank_transfer: 1}
  enum order_status:{waiting: 0, confirm: 1, in_production: 2, preparation: 3, shipped:4}
end