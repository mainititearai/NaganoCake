class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@orders = Order.all.reverse_order
		@order_items = OrderItem.all.reverse_order
	end

	def show
	end

	def update
	end

	def item_update
	end
end
