class ShippingAddress < ApplicationRecord
  belongs_to :member

    def postcode_address_name
    	self.postcode + " " + self.address + " " + " " + self.name
    end
end