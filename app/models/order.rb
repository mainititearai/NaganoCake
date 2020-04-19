class Order < ApplicationRecord
  belongs_to :member
  has_many :order_items, dependent: :destroy

  enum payment_method:{credit_card: 0, bank_transfer: 1}
end