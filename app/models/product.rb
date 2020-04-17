class Product < ApplicationRecord
  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  enum sale_status:{active: 0,is_deleted: 1}
  attachment :image
end