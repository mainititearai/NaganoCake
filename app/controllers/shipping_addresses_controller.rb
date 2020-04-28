class ShippingAddressesController < ApplicationController

	def index
	  @member = current_member
	  @shipping_addresses = @member.shipping_addresses.all.reverse_order
      @shipping_address = ShippingAddress.new
	end

	def create
      @shipping_address = ShippingAddress.new(shipping_address_params)
      @shipping_address.member = current_member
      if @shipping_address.save
         redirect_to member_shipping_addresses_path ,notice:"配送先登録完了しました"
      else
         redirect_to member_shipping_addresses_path ,notice:"空欄があります"
      end
	end

	def edit
	  @shipping_address = ShippingAddress.find(params[:id])


	end

	def update
	  shipping_address = ShippingAddress.find(params[:id])
	  if shipping_address.update(shipping_address_params)
	     redirect_to member_shipping_addresses_path ,notice: "配送先変更完了しました"
     else
     	 redirect_to edit_member_shipping_address_url ,notice: "空欄があります"
     end
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
