class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :email,:last_name,:first_name,:last_name_kana,:first_name_kana,:address,:postcode,:phone_number, presence: :true

  # enumで論理削除機能
  enum valid_status: { active: 0, is_deleted: 1 }

  def withdraw!
    if active?
      is_deleted!
    else
      active!
    end
  end

  def active_for_authentication?
     super && self.valid_status == "active"
  end

  def self.search(search)
    return Member.all unless search
    Member.where(['last_name LIKE ?', "%#{search}%"])
  end

  end
