class Genre < ApplicationRecord
	has_many :products
	validates :name, presence: true
	validates :valid_status, presence: true
	enum valid_status:{active: 0,is_deleted: 1}

	def update!
		if active?
			is_deleted!
		else
			active
		end
	end

end
