class CartItemsController < ApplicationController

	def index
		@cart_items = CartItem.all
		@sum = 0
	end

	def create
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.save
		redirect_to member_cart_items_path
	end

	def update
		@cart_item = CartItem.find(params[:id])
		@cart_item.update(cart_item_params)
		redirect_to member_cart_items_path
	end

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to member_cart_items_path
	end

	def destroy_all
		current_member.cart_items.destroy_all
		redirect_to root_path
	end
	private

	def cart_item_params
		params.require(:cart_item).permit(:member_id, :product_id, :quantity)
	end
end
