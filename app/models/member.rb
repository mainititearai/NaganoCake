class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :email,:last_name,:first_name,:last_name_kana,:first_name_kana,:address,:postcode,:phone_number,  presence: :true


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
    Member.where(['last_name LIKE ? OR first_name LIKE ? OR last_name_kana LIKE ? OR first_name_kana LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
def update_without_password(params, *options)#
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
    validate validate! _validators
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


  end
