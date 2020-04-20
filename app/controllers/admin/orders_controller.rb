class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@orders = Order.all.reverse_order
	end

	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items.all
		@order_item = OrderItem.find(params[:id])
	end

	def update
		@cart_item = CartItem.find(params[:id])
	end

	def item_update
	end
end
