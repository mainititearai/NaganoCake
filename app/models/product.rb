class Product < ApplicationRecord
  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  enum sale_status:{active: 0,is_deleted: 1}
  enum recommend_status:{recommend: 0, unrecommend: 1}
  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def self.search(search)
    return Product.all unless search
    Product.where(['name LIKE ?',"%#{search}%"])
  end
end