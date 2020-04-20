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
		redirect_to admin_orders_path
	end

	def item_update
		@order_item =
		@order_item.update
		redirect_to admin_orders_path
	end


	def order_params
		params.require(:order).permit(:member_id,:name, :postcode, :address, :payment_method, :order_status)
	end

end
