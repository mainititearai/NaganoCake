class CartItemsController < ApplicationController

	def index
		@cart_items = CartItem.all
		@sum = 0
	end

	def create
		@product = Product.find(params[:cart_item][:product_id])
		if CartItem.exists?(product_id: @product)
		@cart_item = CartItem.find_by(product_id: @product.id)
		@cart_item.quantity += params[:cart_item][:quantity].to_i
		@cart_item.update(quantity: @cart_item.quantity)
		else
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.save
	    end
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
