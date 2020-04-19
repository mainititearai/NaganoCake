class ShippingAddressesController < ApplicationController

	def index
	  @shipping_addresses = ShippingAddress.all
      @shipping_address = ShippingAddress.new
	end

	def create
      @shipping_address = ShippingAddress.new(shipping_address_params)
      @shipping_address.member = current_member
      @shipping_address.save
      redirect_to member_shipping_addresses_path
	end

	def edit
	  @shipping_address = ShippingAddress.find(params[:id])


	end

	def update
	  shipping_address = ShippingAddress.find(params[:id])
	  shipping_address.update(shipping_address_params)
	  redirect_to member_shipping_addresses_path
	end


	def destroy
      shipping_address = ShippingAddress.find(params[:id])
	  shipping_address.destroy
	  redirect_to member_shipping_addresses_path
	end

private

def shipping_address_params
	params.require(:shipping_address).permit(:postcode, :address, :name, :member_id)
end
end
