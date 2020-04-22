class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@orders = Order.all.reverse_order
	end

	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items.all
		@sum = 0
		# @order_item = OrderItem.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		redirect_back(fallback_location: root_url)
	end

	def item_update
		@order_item = OrderItem.find(params[:id])
		@order_item.update(order_item_params)
		redirect_back(fallback_location: root_url)
	end


	def order_params
		params.require(:order).permit(:member_id,:name, :postcode, :address, :payment_method, :order_status)
	end
	def order_item_params
		params.require(:order_item).permit(:order_id, :product_id, :quantity, :price, :production_status)
	end

end
